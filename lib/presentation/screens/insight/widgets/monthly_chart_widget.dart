import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../providers/insight_provider.dart';

/// 월별 지출 그래프 위젯
class MonthlyChartWidget extends StatelessWidget {
  final InsightProvider provider;

  const MonthlyChartWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final monthlyData = provider.getMonthlySpending();

    if (monthlyData.isEmpty) {
      return const SizedBox.shrink();
    }

    final maxValue = monthlyData.values.reduce((a, b) => a > b ? a : b);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            Row(
              children: [
                Icon(Icons.bar_chart, color: AppColors.primary, size: 24),
                const SizedBox(width: AppSizes.spaceSm),
                Text('월별 지출 추이', style: AppTextStyles.h4),
              ],
            ),
            const SizedBox(height: AppSizes.spaceMd),

            // 그래프
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxValue > 0 ? maxValue * 1.2 : 100000,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${group.x + 1}월\n',
                          AppTextStyles.caption.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: _formatAmount(rod.toY.toInt()),
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              '${value.toInt() + 1}',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textTertiary,
                              ),
                            ),
                          );
                        },
                        reservedSize: 30,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 45,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            _formatShortAmount(value.toInt()),
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textTertiary,
                              fontSize: 10,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: maxValue > 0 ? maxValue / 5 : 20000,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(color: AppColors.grey200, strokeWidth: 1);
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: _createBarGroups(monthlyData),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _createBarGroups(Map<int, int> monthlyData) {
    return monthlyData.entries.map((entry) {
      final month = entry.key;
      final amount = entry.value;

      return BarChartGroupData(
        x: month - 1, // 0-based index
        barRods: [
          BarChartRodData(
            toY: amount.toDouble(),
            color: AppColors.primary,
            width: 16,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              color: AppColors.grey100,
            ),
          ),
        ],
      );
    }).toList();
  }

  String _formatAmount(int amount) {
    if (amount >= 1000000) {
      return '₩${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '₩${(amount / 1000).toStringAsFixed(0)}K';
    } else {
      return '₩$amount';
    }
  }

  String _formatShortAmount(int amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(0)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}K';
    } else {
      return '$amount';
    }
  }
}
