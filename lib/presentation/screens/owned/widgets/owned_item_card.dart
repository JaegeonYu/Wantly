import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../data/models/owned_item.dart';
import '../../../providers/owned_provider.dart';

/// 구매 완료 아이템 카드
class OwnedItemCard extends StatelessWidget {
  final OwnedItem item;
  final int? dragIndex;

  const OwnedItemCard({super.key, required this.item, this.dragIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spaceMd),
      child: Slidable(
        key: ValueKey(item.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            // 편집
            SlidableAction(
              onPressed: (_) {
                // TODO: 상세/편집 화면으로 이동
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
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              // TODO: 상세 화면으로 이동
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 이미지
                _buildImage(),

                // 정보
                Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 물품명과 드래그 핸들
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: AppTextStyles.h4,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (dragIndex != null)
                            ReorderableDragStartListener(
                              index: dragIndex!,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  Icons.drag_handle,
                                  color: AppColors.grey400,
                                  size: 20,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.spaceXs),

                      // 별점
                      RatingBarIndicator(
                        rating: item.satisfactionScore.toDouble(),
                        itemBuilder: (context, index) =>
                            const Icon(Icons.star, color: AppColors.warning),
                        itemCount: 5,
                        itemSize: 20.0,
                      ),
                      const SizedBox(height: AppSizes.spaceXs),

                      // 가격 정보
                      Row(
                        children: [
                          Text(
                            '실제: ${item.formattedActualPrice}',
                            style: AppTextStyles.priceMedium,
                          ),
                          const SizedBox(width: AppSizes.spaceSm),
                          if (item.expectedPrice != null)
                            Text(
                              '예상: ${item.formattedEstimatedPrice}',
                              style: AppTextStyles.body2.copyWith(
                                color: AppColors.textSecondary,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),

                      // 가격 차이
                      if (item.expectedPrice != null &&
                          item.priceDifference != 0)
                        Padding(
                          padding: const EdgeInsets.only(top: AppSizes.spaceXs),
                          child: Row(
                            children: [
                              Icon(
                                item.priceDifference > 0
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                size: 14,
                                color: item.priceDifference > 0
                                    ? AppColors.error
                                    : AppColors.success,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                item.formattedPriceDifference,
                                style: AppTextStyles.caption.copyWith(
                                  color: item.priceDifference > 0
                                      ? AppColors.error
                                      : AppColors.success,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(height: AppSizes.spaceXs),

                      // 구매일
                      Text(
                        '${item.purchasedDaysAgo}일 전 구매',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),

                      // 후기 미리보기
                      if (item.review.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: AppSizes.spaceSm),
                          child: Text(
                            item.review,
                            style: AppTextStyles.body2,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 이미지 빌드
  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: item.hasImage
          ? Image.network(
              item.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _buildPlaceholder(),
            )
          : _buildPlaceholder(),
    );
  }

  /// 플레이스홀더
  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.grey100,
      child: Center(
        child: Icon(
          Icons.shopping_bag_outlined,
          size: 60,
          color: AppColors.grey400,
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
              final success = await context.read<OwnedProvider>().deleteItem(
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
