import '../../data/models/wishlist_item.dart';

/// 위시리스트 Repository 인터페이스
abstract class WishlistRepository {
  /// 모든 위시리스트 아이템 가져오기
  Future<List<WishlistItem>> getAllItems();

  /// ID로 아이템 가져오기
  Future<WishlistItem?> getItemById(String id);

  /// 카테고리별 아이템 가져오기
  Future<List<WishlistItem>> getItemsByCategory(String categoryId);

  /// 아이템 추가
  Future<void> addItem(WishlistItem item);

  /// 아이템 업데이트
  Future<void> updateItem(WishlistItem item);

  /// 아이템 삭제
  Future<void> deleteItem(String id);

  /// 우선순위 재정렬 (드래그앤드롭)
  Future<void> reorderItems(List<String> orderedIds);

  /// 총 아이템 개수
  Future<int> getItemCount();

  /// 총 예상 금액
  Future<int> getTotalPrice();
}
