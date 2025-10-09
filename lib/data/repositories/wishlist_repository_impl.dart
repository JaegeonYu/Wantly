import '../../domain/repositories/wishlist_repository.dart';
import '../../core/utils/logger.dart';
import '../datasources/local/hive_database.dart';
import '../models/wishlist_item.dart';

/// 위시리스트 Repository 구현체
class WishlistRepositoryImpl implements WishlistRepository {
  @override
  Future<List<WishlistItem>> getAllItems() async {
    try {
      final box = HiveDatabase.getWishlistBox();
      final items = box.values.cast<WishlistItem>().toList();

      // priority로 정렬 (숫자가 작을수록 우선순위 높음)
      items.sort((a, b) => a.priority.compareTo(b.priority));

      return items;
    } catch (e, stackTrace) {
      AppLogger.e('위시리스트 가져오기 실패', e, stackTrace);
      return [];
    }
  }

  @override
  Future<WishlistItem?> getItemById(String id) async {
    try {
      final box = HiveDatabase.getWishlistBox();
      return box.get(id) as WishlistItem?;
    } catch (e, stackTrace) {
      AppLogger.e('위시리스트 아이템 가져오기 실패: $id', e, stackTrace);
      return null;
    }
  }

  @override
  Future<List<WishlistItem>> getItemsByCategory(String categoryId) async {
    try {
      final allItems = await getAllItems();
      return allItems.where((item) => item.categoryId == categoryId).toList();
    } catch (e, stackTrace) {
      AppLogger.e('카테고리별 아이템 가져오기 실패', e, stackTrace);
      return [];
    }
  }

  @override
  Future<void> addItem(WishlistItem item) async {
    try {
      final box = HiveDatabase.getWishlistBox();
      await box.put(item.id, item);
      AppLogger.i('위시리스트 추가: ${item.name}');
    } catch (e, stackTrace) {
      AppLogger.e('위시리스트 추가 실패', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> updateItem(WishlistItem item) async {
    try {
      final box = HiveDatabase.getWishlistBox();
      await box.put(item.id, item);
      AppLogger.i('위시리스트 업데이트: ${item.name}');
    } catch (e, stackTrace) {
      AppLogger.e('위시리스트 업데이트 실패', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> deleteItem(String id) async {
    try {
      final box = HiveDatabase.getWishlistBox();
      await box.delete(id);
      AppLogger.i('위시리스트 삭제: $id');
    } catch (e, stackTrace) {
      AppLogger.e('위시리스트 삭제 실패', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> reorderItems(List<String> orderedIds) async {
    try {
      final box = HiveDatabase.getWishlistBox();

      // 각 아이템의 priority를 순서대로 업데이트
      for (var i = 0; i < orderedIds.length; i++) {
        final item = box.get(orderedIds[i]) as WishlistItem?;
        if (item != null) {
          final updatedItem = item.copyWith(
            priority: i,
            updatedAt: DateTime.now(),
          );
          await box.put(item.id, updatedItem);
        }
      }

      AppLogger.i('위시리스트 순서 변경: ${orderedIds.length}개');
    } catch (e, stackTrace) {
      AppLogger.e('위시리스트 순서 변경 실패', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<int> getItemCount() async {
    try {
      final box = HiveDatabase.getWishlistBox();
      return box.length;
    } catch (e, stackTrace) {
      AppLogger.e('위시리스트 개수 가져오기 실패', e, stackTrace);
      return 0;
    }
  }

  @override
  Future<int> getTotalPrice() async {
    try {
      final items = await getAllItems();
      return items.fold<int>(0, (sum, item) => sum + item.price);
    } catch (e, stackTrace) {
      AppLogger.e('총 금액 계산 실패', e, stackTrace);
      return 0;
    }
  }
}
