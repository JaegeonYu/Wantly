import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../data/models/category.dart';
import '../../../providers/insight_provider.dart';

/// 카테고리별 지출 도넛 차트 위젯
class CategoryChartWidget extends StatelessWidget {
  final InsightProvider provider;

  const CategoryChartWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final categoryData = provider.getCategorySpending();

    if (categoryData.isEmpty) {
      return const SizedBox.shrink();
    }

    final totalSpent = provider.getTotalSpent();
    final sortedEntries = categoryData.entries.toList()
      ..sort((a, b) => b.value.totalSpent.compareTo(a.value.totalSpent));

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
                Icon(Icons.pie_chart, color: AppColors.primary, size: 24),
                const SizedBox(width: AppSizes.spaceSm),
                Text('카테고리별 지출', style: AppTextStyles.h4),
              ],
            ),
            const SizedBox(height: AppSizes.spaceMd),

            // 차트와 범례
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 도넛 차트
                SizedBox(
                  width: 150,
                  height: 150,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: _createSections(sortedEntries, totalSpent),
                      pieTouchData: PieTouchData(
                        touchCallback:
                            (FlTouchEvent event, pieTouchResponse) {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.spaceMd),

                // 범례
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: sortedEntries.map((entry) {
                      final data = entry.value;
                      final percentage = data.getPercentage(totalSpent);

                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppSizes.spaceXs,
                        ),
                        child: Row(
                          children: [
                            // 색상 인디케이터
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: data.category.color,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: AppSizes.spaceXs),

                            // 카테고리 정보
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.category.name,
                                    style: AppTextStyles.body2.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${percentage.toStringAsFixed(1)}% · ${data.itemCount}개',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _createSections(
    List<MapEntry<String, CategorySpending>> entries,
    int totalSpent,
  ) {
    return entries.map((entry) {
      final data = entry.value;
      final percentage = data.getPercentage(totalSpent);

      return PieChartSectionData(
        value: data.totalSpent.toDouble(),
        title: '${percentage.toStringAsFixed(0)}%',
        color: data.category.color,
        radius: 50,
        titleStyle: AppTextStyles.caption.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      );
    }).toList();
  }
}
