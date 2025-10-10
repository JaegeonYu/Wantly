import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../data/models/owned_item.dart';
import '../../../../data/models/category.dart';
import '../../../providers/insight_provider.dart';

/// 베스트/워스트 구매 위젯
class BestWorstWidget extends StatelessWidget {
  final InsightProvider provider;

  const BestWorstWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final bestPurchases = provider.getBestPurchases(limit: 3);
    final worstPurchases = provider.getWorstPurchases(limit: 3);

    if (bestPurchases.isEmpty && worstPurchases.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 베스트 구매
        if (bestPurchases.isNotEmpty) ...[
          _SectionHeader(
            icon: Icons.emoji_events,
            iconColor: AppColors.warning,
            title: '최고의 구매',
          ),
          const SizedBox(height: AppSizes.spaceSm),
          ...bestPurchases.map(
            (item) =>
                _PurchaseItem(item: item, provider: provider, isPositive: true),
          ),
          const SizedBox(height: AppSizes.spaceLg),
        ],

        // 워스트 구매
        if (worstPurchases.isNotEmpty) ...[
          _SectionHeader(
            icon: Icons.sentiment_dissatisfied,
            iconColor: AppColors.error,
            title: '아쉬운 구매',
          ),
          const SizedBox(height: AppSizes.spaceSm),
          ...worstPurchases.map(
            (item) => _PurchaseItem(
              item: item,
              provider: provider,
              isPositive: false,
            ),
          ),
        ],
      ],
    );
  }
}

/// 섹션 헤더
class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;

  const _SectionHeader({
    required this.icon,
    required this.iconColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: AppSizes.spaceSm),
        Text(title, style: AppTextStyles.h4),
      ],
    );
  }
}

/// 구매 아이템
class _PurchaseItem extends StatelessWidget {
  final OwnedItem item;
  final InsightProvider provider;
  final bool isPositive;

  const _PurchaseItem({
    required this.item,
    required this.provider,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    final category = provider.getCategoryById(item.categoryId);

    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.spaceSm),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingSm),
        child: Row(
          children: [
            // 순위 배지
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isPositive
                    ? AppColors.success.withOpacity(0.1)
                    : AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              child: Center(
                child: Icon(
                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isPositive ? AppColors.success : AppColors.error,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: AppSizes.spaceSm),

            // 아이템 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: AppTextStyles.body1.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // 만족도
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getSatisfactionColor(
                            item.satisfactionScore,
                          ).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              size: 14,
                              color: _getSatisfactionColor(
                                item.satisfactionScore,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              item.satisfactionScore.toStringAsFixed(1),
                              style: AppTextStyles.caption.copyWith(
                                color: _getSatisfactionColor(
                                  item.satisfactionScore,
                                ),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (category != null) ...[
                        Icon(category.icon, size: 14, color: category.color),
                        const SizedBox(width: 4),
                        Text(
                          category.name,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        item.formattedActualPrice,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSatisfactionColor(double score) {
    if (score >= 4.0) return AppColors.success;
    if (score >= 2.5) return AppColors.warning;
    return AppColors.error;
  }
}
