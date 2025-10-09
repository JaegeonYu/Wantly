import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/text_styles.dart';
import '../../providers/wishlist_provider.dart';
import 'widgets/wishlist_item_card.dart';
import 'widgets/empty_wishlist_widget.dart';
import 'add_edit_wishlist_screen.dart';

/// 위시리스트 화면
class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    // 화면 로드 시 위시리스트 불러오기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WishlistProvider>().loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.wishlistTitle),
        actions: [
          // 총 금액 표시
          Consumer<WishlistProvider>(
            builder: (context, provider, _) {
              return FutureBuilder<int>(
                future: provider.getTotalPrice(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data! > 0) {
                    final total = snapshot.data!;
                    final formatted =
                        '₩${total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
                    return Padding(
                      padding: const EdgeInsets.all(AppSizes.paddingMd),
                      child: Center(
                        child: Text(
                          formatted,
                          style: AppTextStyles.priceMedium,
                        ),
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
      body: Consumer<WishlistProvider>(
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
            return const EmptyWishlistWidget();
          }

          // 위시리스트 표시
          return ReorderableListView.builder(
            padding: const EdgeInsets.all(AppSizes.paddingSm),
            itemCount: provider.items.length,
            onReorder: provider.reorderItems,
            buildDefaultDragHandles: false, // 기본 드래그 핸들 비활성화
            itemBuilder: (context, index) {
              final item = provider.items[index];
              return WishlistItemCard(
                key: ValueKey(item.id),
                item: item,
                rank: index + 1,
                showDragHandle: true,
                dragIndex: index, // 드래그 핸들에서 사용할 인덱스
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditWishlistScreen(),
            ),
          );
          // 아이템 추가 후 돌아왔을 때 자동으로 리스트 갱신됨 (Provider 사용)
        },
        icon: const Icon(Icons.add),
        label: const Text(AppStrings.addItem),
      ),
    );
  }
}
