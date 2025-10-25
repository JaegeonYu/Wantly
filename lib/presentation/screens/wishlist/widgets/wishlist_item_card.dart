import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../data/models/wishlist_item.dart';
import '../../../../data/models/owned_item.dart';
import '../../../providers/wishlist_provider.dart';
import '../../../providers/owned_provider.dart';
import '../../../providers/insight_provider.dart';
import '../add_edit_wishlist_screen.dart';
import '../wishlist_detail_screen.dart';

/// 위시리스트 아이템 카드
class WishlistItemCard extends StatelessWidget {
  final WishlistItem item;
  final int rank;
  final bool showDragHandle;
  final int? dragIndex; // ReorderableListView에서 사용할 인덱스

  const WishlistItemCard({
    super.key,
    required this.item,
    required this.rank,
    this.showDragHandle = false,
    this.dragIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spaceSm),
      child: Slidable(
        key: ValueKey(item.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            // 구매 완료
            SlidableAction(
              onPressed: (_) => _showPurchaseDialog(context),
              backgroundColor: AppColors.success,
              foregroundColor: AppColors.white,
              icon: Icons.shopping_cart_checkout,
              label: '구매완료',
            ),
            // 편집
            SlidableAction(
              onPressed: (_) async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditWishlistScreen(item: item),
                  ),
                );

                // 수정 후 리스트 갱신 (명시적으로 리프레시)
                if (result == true && context.mounted) {
                  await context.read<WishlistProvider>().loadItems();
                }
              },
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              icon: Icons.edit,
              label: '편집',
            ),
            // 삭제
            SlidableAction(
              onPressed: (_) => _showDeleteDialog(context),
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.white,
              icon: Icons.delete,
              label: '삭제',
            ),
          ],
        ),
        child: Card(
          elevation: 2,
          child: InkWell(
            onTap: () {
              // 상세 화면으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WishlistDetailScreen(item: item),
                ),
              );
            },
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingMd),
              child: Row(
                children: [
                  // 우선순위 배지
                  _buildRankBadge(),
                  const SizedBox(width: AppSizes.spaceMd),

                  // 이미지 또는 아이콘
                  _buildImage(),
                  const SizedBox(width: AppSizes.spaceMd),

                  // 정보
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 물품명
                        Text(
                          item.name,
                          style: AppTextStyles.h4,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppSizes.spaceXs),

                        // 가격
                        Text(
                          item.formattedPrice,
                          style: AppTextStyles.priceMedium,
                        ),
                        const SizedBox(height: AppSizes.spaceXs),

                        // 사고 싶은 이유 (미리보기)
                        if (item.reason.isNotEmpty)
                          Text(
                            item.reason,
                            style: AppTextStyles.body2,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                        const SizedBox(height: AppSizes.spaceXs),

                        // 등록일
                        Text(
                          '${item.daysAgo}일 전',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 드래그 핸들 (순서 변경 시에만 표시)
                  if (showDragHandle && dragIndex != null)
                    ReorderableDragStartListener(
                      index: dragIndex!,
                      child: Container(
                        padding: const EdgeInsets.all(AppSizes.spaceXs),
                        decoration: BoxDecoration(
                          color: AppColors.grey100,
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusSm,
                          ),
                        ),
                        child: const Icon(
                          Icons.drag_handle,
                          color: AppColors.grey600,
                          size: 24,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 우선순위 배지
  Widget _buildRankBadge() {
    Color badgeColor;
    if (rank == 1) {
      badgeColor = const Color(0xFFFFD700); // 금색
    } else if (rank == 2) {
      badgeColor = const Color(0xFFC0C0C0); // 은색
    } else if (rank == 3) {
      badgeColor = const Color(0xFFCD7F32); // 동색
    } else {
      badgeColor = AppColors.grey300;
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(color: badgeColor, shape: BoxShape.circle),
      child: Center(
        child: Text(
          '$rank',
          style: AppTextStyles.bodyBold.copyWith(
            color: rank <= 3 ? AppColors.white : AppColors.textPrimary,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  /// 이미지 또는 플레이스홀더
  Widget _buildImage() {
    return Container(
      width: AppSizes.thumbnailSize,
      height: AppSizes.thumbnailSize,
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      ),
      child: item.hasImage
          ? ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              child: _buildImageWidget(item.imageUrl!),
            )
          : _buildPlaceholder(),
    );
  }

  /// 이미지 위젯 빌드 (로컬 파일 또는 네트워크 URL 처리)
  Widget _buildImageWidget(String imagePath) {
    // URL인지 로컬 파일인지 확인
    final isUrl =
        imagePath.startsWith('http://') || imagePath.startsWith('https://');

    if (isUrl) {
      // 네트워크 이미지
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    } else {
      // 로컬 파일 이미지
      if (kIsWeb) {
        // 웹 환경에서는 네트워크 이미지로 처리
        return Image.network(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildPlaceholder(),
        );
      } else {
        // 모바일 환경에서는 파일 이미지로 처리
        return Image.file(
          File(imagePath),
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildPlaceholder(),
        );
      }
    }
  }

  /// 플레이스홀더 아이콘
  Widget _buildPlaceholder() {
    return const Icon(
      Icons.shopping_bag_outlined,
      size: 40,
      color: AppColors.grey400,
    );
  }

  /// 구매 완료 다이얼로그
  void _showPurchaseDialog(BuildContext context) {
    final priceController = TextEditingController(text: item.price.toString());
    double satisfactionScore = 3.0; // 기본값 3점

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('구매 완료'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${item.name}을(를) 구매하셨나요?'),
                const SizedBox(height: AppSizes.spaceMd),

                // 실제 구매 가격 입력
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: '실제 구매 가격',
                    suffixText: '원',
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: AppSizes.spaceLg),

                // 만족도 별점
                const Text(
                  '만족도',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSizes.spaceSm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    final starValue = index + 1.0;
                    return IconButton(
                      icon: Icon(
                        starValue <= satisfactionScore
                            ? Icons.star
                            : Icons.star_border,
                        color: AppColors.starColor,
                        size: 36,
                      ),
                      onPressed: () {
                        setState(() {
                          satisfactionScore = starValue;
                        });
                      },
                    );
                  }),
                ),
                Center(
                  child: Text(
                    '${satisfactionScore.toStringAsFixed(1)}점',
                    style: AppTextStyles.h4.copyWith(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () async {
                final actualPrice = int.tryParse(priceController.text);
                if (actualPrice == null || actualPrice <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('올바른 가격을 입력해주세요')),
                  );
                  return;
                }

                Navigator.pop(context);

                // OwnedItem으로 변환 (예상 가격과 생성일 포함)
                final ownedItem = OwnedItem(
                  id: const Uuid().v4(),
                  name: item.name,
                  categoryId: item.categoryId,
                  actualPrice: actualPrice,
                  expectedPrice: item.price, // 위시리스트의 예상 가격
                  imageUrl: item.imageUrl,
                  purchaseDate: DateTime.now(),
                  satisfactionScore: satisfactionScore, // 입력받은 별점
                  createdAt: item.createdAt, // 위시리스트 등록 날짜
                  review: '',
                  tags: item.tags,
                  memo: item.memo,
                );

                // Owned에 추가
                final ownedSuccess = await context
                    .read<OwnedProvider>()
                    .addItem(ownedItem);

                if (ownedSuccess) {
                  // Wishlist에서 삭제
                  await context.read<WishlistProvider>().deleteItem(item.id);

                  // 인사이트 Provider 갱신 (즉시 반영)
                  if (context.mounted) {
                    await context.read<InsightProvider>().loadData();
                  }

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('구매 완료되었습니다! 🎉')),
                    );
                  }
                }
              },
              child: const Text('완료'),
            ),
          ],
        ),
      ),
    );
  }

  /// 삭제 확인 다이얼로그
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('삭제 확인'),
        content: Text('${item.name}을(를) 삭제하시겠어요?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await context.read<WishlistProvider>().deleteItem(
                item.id,
              );
              if (context.mounted && success) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('삭제되었습니다')));
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}
