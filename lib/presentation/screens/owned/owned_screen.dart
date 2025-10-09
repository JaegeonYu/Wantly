import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/text_styles.dart';
import '../../providers/owned_provider.dart';
import 'widgets/owned_item_card.dart';
import 'widgets/empty_owned_widget.dart';

/// 구매 완료 목록 화면
class OwnedScreen extends StatefulWidget {
  const OwnedScreen({super.key});

  @override
  State<OwnedScreen> createState() => _OwnedScreenState();
}

class _OwnedScreenState extends State<OwnedScreen> {
  @override
  void initState() {
    super.initState();
    // 화면 로드 시 구매 목록 불러오기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OwnedProvider>().loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('구매 목록'),
        actions: [
          // 통계 표시
          Consumer<OwnedProvider>(
            builder: (context, provider, _) {
              return FutureBuilder<Map<String, dynamic>>(
                future: _getStatistics(provider),
                builder: (context, snapshot) {
                  if (snapshot.hasData && provider.itemCount > 0) {
                    final data = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(AppSizes.paddingMd),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '총 ${provider.itemCount}개',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            '평균 ⭐ ${data['avgSatisfaction'].toStringAsFixed(1)}',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.warning,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<OwnedProvider>(
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
                    onPressed: provider.loadItems,
                    child: const Text('다시 시도'),
                  ),
                ],
              ),
            );
          }

          // 빈 상태
          if (provider.isEmpty) {
            return const EmptyOwnedWidget();
          }

          // 구매 목록 표시 (만족도 순)
          return ReorderableListView.builder(
            padding: const EdgeInsets.all(AppSizes.paddingSm),
            itemCount: provider.items.length,
            onReorder: provider.reorderItems,
            buildDefaultDragHandles: false,
            itemBuilder: (context, index) {
              final item = provider.items[index];
              return OwnedItemCard(
                key: ValueKey(item.id),
                item: item,
                dragIndex: index,
              );
            },
          );
        },
      ),
    );
  }

  /// 통계 데이터 가져오기
  Future<Map<String, dynamic>> _getStatistics(OwnedProvider provider) async {
    final totalSpent = await provider.getTotalSpent();
    final avgSatisfaction = await provider.getAverageSatisfaction();

    return {'totalSpent': totalSpent, 'avgSatisfaction': avgSatisfaction};
  }
}
