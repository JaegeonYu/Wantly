import '../../data/models/owned_item.dart';

/// 구매완료 Repository 인터페이스
abstract class OwnedRepository {
  /// 모든 구매완료 아이템 가져오기
  Future<List<OwnedItem>> getAllItems();

  /// ID로 아이템 가져오기
  Future<OwnedItem?> getItemById(String id);

  /// 카테고리별 아이템 가져오기
  Future<List<OwnedItem>> getItemsByCategory(String categoryId);

  /// 연도별 아이템 가져오기
  Future<List<OwnedItem>> getItemsByYear(int year);

  /// 월별 아이템 가져오기
  Future<List<OwnedItem>> getItemsByMonth(int year, int month);

  /// 아이템 추가
  Future<void> addItem(OwnedItem item);

  /// 아이템 업데이트
  Future<void> updateItem(OwnedItem item);

  /// 아이템 삭제
  Future<void> deleteItem(String id);

  /// 만족도 순위 재정렬 (드래그앤드롭)
  Future<void> reorderBySatisfaction(List<String> orderedIds);

  /// 총 아이템 개수
  Future<int> getItemCount();

  /// 총 지출 금액
  Future<int> getTotalSpent();

  /// 평균 만족도
  Future<double> getAverageSatisfaction();

  /// 카테고리별 지출 통계
  Future<Map<String, int>> getSpendingByCategory();
}
