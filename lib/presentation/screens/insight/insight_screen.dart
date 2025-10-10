import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/text_styles.dart';
import '../../providers/insight_provider.dart';
import 'widgets/stats_card_widget.dart';
import 'widgets/monthly_chart_widget.dart';
import 'widgets/category_chart_widget.dart';
import 'widgets/best_worst_widget.dart';

/// 인사이트(통계) 화면
class InsightScreen extends StatefulWidget {
  const InsightScreen({super.key});

  @override
  State<InsightScreen> createState() => _InsightScreenState();
}

class _InsightScreenState extends State<InsightScreen> {
  @override
  void initState() {
    super.initState();
    // 화면 로드 시 데이터 불러오기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InsightProvider>().loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('소비 인사이트'),
        actions: [
          // 기간 필터
          Consumer<InsightProvider>(
            builder: (context, provider, _) {
              return PopupMenuButton<InsightPeriod>(
                icon: const Icon(Icons.filter_list),
                onSelected: provider.setPeriod,
                initialValue: provider.selectedPeriod,
                itemBuilder: (context) => InsightPeriod.values
                    .map(
                      (period) => PopupMenuItem(
                        value: period,
                        child: Row(
                          children: [
                            if (period == provider.selectedPeriod)
                              const Icon(
                                Icons.check,
                                color: AppColors.primary,
                                size: 20,
                              )
                            else
                              const SizedBox(width: 20),
                            const SizedBox(width: AppSizes.spaceSm),
                            Text(period.label),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
      body: Consumer<InsightProvider>(
        builder: (context, provider, _) {
          // 로딩 중
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 에러 발생
          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: AppSizes.spaceMd),
                  Text(provider.errorMessage!, style: AppTextStyles.body1),
                  const SizedBox(height: AppSizes.spaceMd),
                  ElevatedButton(
                    onPressed: provider.loadData,
                    child: const Text('다시 시도'),
                  ),
                ],
              ),
            );
          }

          // 데이터 없음
          if (provider.filteredItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.insights_outlined,
                    size: 80,
                    color: AppColors.grey400,
                  ),
                  const SizedBox(height: AppSizes.spaceMd),
                  Text(
                    '구매 데이터가 없습니다',
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceSm),
                  Text(
                    '위시리스트에서 물건을 구매해보세요!',
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            );
          }

          // 인사이트 표시
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.paddingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 기간 표시
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingSm,
                    vertical: AppSizes.paddingXs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                  child: Text(
                    '${provider.selectedPeriod.label} 분석',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceLg),

                // 주요 지표 카드
                StatsCardWidget(provider: provider),
                const SizedBox(height: AppSizes.spaceLg),

                // 월별 지출 그래프
                MonthlyChartWidget(provider: provider),
                const SizedBox(height: AppSizes.spaceLg),

                // 카테고리별 지출
                CategoryChartWidget(provider: provider),
                const SizedBox(height: AppSizes.spaceLg),

                // 베스트/워스트 구매
                BestWorstWidget(provider: provider),
                const SizedBox(height: AppSizes.spaceXl),
              ],
            ),
          );
        },
      ),
    );
  }
}
