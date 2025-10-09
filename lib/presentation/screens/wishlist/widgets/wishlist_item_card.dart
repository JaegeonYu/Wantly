import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../data/models/wishlist_item.dart';
import '../../../providers/wishlist_provider.dart';

/// 위시리스트 아이템 카드
class WishlistItemCard extends StatelessWidget {
  final WishlistItem item;
  final int rank;

  const WishlistItemCard({super.key, required this.item, required this.rank});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spaceSm),
      child: Slidable(
        key: ValueKey(item.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            // 편집
            SlidableAction(
              onPressed: (_) {
                // TODO: 편집 화면으로 이동
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
              // TODO: 상세 화면으로 이동
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

                  // 드래그 핸들
                  const Icon(Icons.drag_handle, color: AppColors.grey400),
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
              child: Image.asset(
                item.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildPlaceholder(),
              ),
            )
          : _buildPlaceholder(),
    );
  }

  /// 플레이스홀더 아이콘
  Widget _buildPlaceholder() {
    return const Icon(
      Icons.shopping_bag_outlined,
      size: 40,
      color: AppColors.grey400,
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
