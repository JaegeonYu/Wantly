import '../../domain/repositories/owned_repository.dart';
import '../../core/utils/logger.dart';
import '../datasources/local/hive_database.dart';
import '../models/owned_item.dart';

/// 구매완료 Repository 구현체
class OwnedRepositoryImpl implements OwnedRepository {
  @override
  Future<List<OwnedItem>> getAllItems() async {
    try {
      final box = HiveDatabase.getOwnedBox();
      final items = box.values.cast<OwnedItem>().toList();

      // 구매 날짜 최신순으로 정렬
      items.sort((a, b) => b.purchaseDate.compareTo(a.purchaseDate));

      return items;
    } catch (e, stackTrace) {
      AppLogger.e('구매완료 목록 가져오기 실패', e, stackTrace);
      return [];
    }
  }

  @override
  Future<OwnedItem?> getItemById(String id) async {
    try {
      final box = HiveDatabase.getOwnedBox();
      return box.get(id) as OwnedItem?;
    } catch (e, stackTrace) {
      AppLogger.e('구매완료 아이템 가져오기 실패: $id', e, stackTrace);
      return null;
    }
  }

  @override
  Future<List<OwnedItem>> getItemsByCategory(String categoryId) async {
    try {
      final allItems = await getAllItems();
      return allItems.where((item) => item.categoryId == categoryId).toList();
    } catch (e, stackTrace) {
      AppLogger.e('카테고리별 아이템 가져오기 실패', e, stackTrace);
      return [];
    }
  }

  @override
  Future<List<OwnedItem>> getItemsByYear(int year) async {
    try {
      final allItems = await getAllItems();
      return allItems.where((item) => item.purchaseDate.year == year).toList();
    } catch (e, stackTrace) {
      AppLogger.e('연도별 아이템 가져오기 실패', e, stackTrace);
      return [];
    }
  }

  @override
  Future<List<OwnedItem>> getItemsByMonth(int year, int month) async {
    try {
      final allItems = await getAllItems();
      return allItems
          .where(
            (item) =>
                item.purchaseDate.year == year &&
                item.purchaseDate.month == month,
          )
          .toList();
    } catch (e, stackTrace) {
      AppLogger.e('월별 아이템 가져오기 실패', e, stackTrace);
      return [];
    }
  }

  @override
  Future<void> addItem(OwnedItem item) async {
    try {
      final box = HiveDatabase.getOwnedBox();
      await box.put(item.id, item);
      AppLogger.i('구매완료 추가: ${item.name}');
    } catch (e, stackTrace) {
      AppLogger.e('구매완료 추가 실패', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> updateItem(OwnedItem item) async {
    try {
      final box = HiveDatabase.getOwnedBox();
      await box.put(item.id, item);
      AppLogger.i('구매완료 업데이트: ${item.name}');
    } catch (e, stackTrace) {
      AppLogger.e('구매완료 업데이트 실패', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> deleteItem(String id) async {
    try {
      final box = HiveDatabase.getOwnedBox();
      await box.delete(id);
      AppLogger.i('구매완료 삭제: $id');
    } catch (e, stackTrace) {
      AppLogger.e('구매완료 삭제 실패', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> reorderBySatisfaction(List<String> orderedIds) async {
    try {
      final box = HiveDatabase.getOwnedBox();

      // 각 아이템의 satisfactionRank를 순서대로 업데이트
      for (var i = 0; i < orderedIds.length; i++) {
        final item = box.get(orderedIds[i]) as OwnedItem?;
        if (item != null) {
          final updatedItem = item.copyWith(satisfactionRank: i);
          await box.put(item.id, updatedItem);
        }
      }

      AppLogger.i('만족도 순서 변경: ${orderedIds.length}개');
    } catch (e, stackTrace) {
      AppLogger.e('만족도 순서 변경 실패', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<int> getItemCount() async {
    try {
      final box = HiveDatabase.getOwnedBox();
      return box.length;
    } catch (e, stackTrace) {
      AppLogger.e('구매완료 개수 가져오기 실패', e, stackTrace);
      return 0;
    }
  }

  @override
  Future<int> getTotalSpent() async {
    try {
      final items = await getAllItems();
      return items.fold<int>(0, (sum, item) => sum + item.actualPrice);
    } catch (e, stackTrace) {
      AppLogger.e('총 지출 계산 실패', e, stackTrace);
      return 0;
    }
  }

  @override
  Future<double> getAverageSatisfaction() async {
    try {
      final items = await getAllItems();
      if (items.isEmpty) return 0.0;

      final totalScore = items.fold<double>(
        0.0,
        (sum, item) => sum + item.satisfactionScore,
      );

      return totalScore / items.length;
    } catch (e, stackTrace) {
      AppLogger.e('평균 만족도 계산 실패', e, stackTrace);
      return 0.0;
    }
  }

  @override
  Future<Map<String, int>> getSpendingByCategory() async {
    try {
      final items = await getAllItems();
      final spending = <String, int>{};

      for (final item in items) {
        spending[item.categoryId] =
            (spending[item.categoryId] ?? 0) + item.actualPrice;
      }

      return spending;
    } catch (e, stackTrace) {
      AppLogger.e('카테고리별 지출 계산 실패', e, stackTrace);
      return {};
    }
  }
}
