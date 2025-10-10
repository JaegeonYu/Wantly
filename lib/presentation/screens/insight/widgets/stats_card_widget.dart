import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../providers/insight_provider.dart';
import 'package:intl/intl.dart';

/// 주요 통계 카드 위젯
class StatsCardWidget extends StatelessWidget {
  final InsightProvider provider;

  const StatsCardWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final totalSpent = provider.getTotalSpent();
    final avgSatisfaction = provider.getAverageSatisfaction();
    final purchaseCount = provider.getPurchaseCount();

    return Row(
      children: [
        // 총 지출
        Expanded(
          child: _StatCard(
            icon: Icons.payments_outlined,
            iconColor: AppColors.primary,
            title: '총 지출',
            value: _formatCurrency(totalSpent),
            valueStyle: AppTextStyles.h3.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: AppSizes.spaceSm),

        // 평균 만족도
        Expanded(
          child: _StatCard(
            icon: Icons.star_rounded,
            iconColor: AppColors.warning,
            title: '평균 만족도',
            value: avgSatisfaction.toStringAsFixed(1),
            valueStyle: AppTextStyles.h3.copyWith(
              color: AppColors.warning,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: AppSizes.spaceSm),

        // 구매 횟수
        Expanded(
          child: _StatCard(
            icon: Icons.shopping_bag_outlined,
            iconColor: AppColors.success,
            title: '구매 횟수',
            value: '$purchaseCount개',
            valueStyle: AppTextStyles.h3.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  String _formatCurrency(int amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}K';
    } else {
      return NumberFormat('#,###').format(amount);
    }
  }
}

/// 개별 통계 카드
class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final TextStyle valueStyle;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 32),
            const SizedBox(height: AppSizes.spaceXs),
            Text(
              title,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spaceXs),
            Text(
              value,
              style: valueStyle,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
