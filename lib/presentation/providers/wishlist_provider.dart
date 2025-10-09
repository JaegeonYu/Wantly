import 'package:flutter/material.dart';
import '../../data/models/wishlist_item.dart';
import '../../data/repositories/wishlist_repository_impl.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../../core/utils/logger.dart';

/// 위시리스트 상태 관리 Provider
class WishlistProvider extends ChangeNotifier {
  final WishlistRepository _repository = WishlistRepositoryImpl();

  List<WishlistItem> _items = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<WishlistItem> get items => _items;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isEmpty => _items.isEmpty;
  int get itemCount => _items.length;

  /// 위시리스트 불러오기
  Future<void> loadItems() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _items = await _repository.getAllItems();
      AppLogger.i('위시리스트 ${_items.length}개 로드 완료');

      _isLoading = false;
      notifyListeners();
    } catch (e, stackTrace) {
      _isLoading = false;
      _errorMessage = '위시리스트를 불러올 수 없습니다';
      AppLogger.e('위시리스트 로드 실패', e, stackTrace);
      notifyListeners();
    }
  }

  /// 아이템 추가
  Future<bool> addItem(WishlistItem item) async {
    try {
      await _repository.addItem(item);
      await loadItems(); // 다시 불러오기
      AppLogger.i('아이템 추가: ${item.name}');
      return true;
    } catch (e, stackTrace) {
      _errorMessage = '아이템을 추가할 수 없습니다';
      AppLogger.e('아이템 추가 실패', e, stackTrace);
      notifyListeners();
      return false;
    }
  }

  /// 아이템 업데이트
  Future<bool> updateItem(WishlistItem item) async {
    try {
      await _repository.updateItem(item);
      await loadItems();
      AppLogger.i('아이템 업데이트: ${item.name}');
      return true;
    } catch (e, stackTrace) {
      _errorMessage = '아이템을 수정할 수 없습니다';
      AppLogger.e('아이템 업데이트 실패', e, stackTrace);
      notifyListeners();
      return false;
    }
  }

  /// 아이템 삭제
  Future<bool> deleteItem(String id) async {
    try {
      await _repository.deleteItem(id);
      await loadItems();
      AppLogger.i('아이템 삭제: $id');
      return true;
    } catch (e, stackTrace) {
      _errorMessage = '아이템을 삭제할 수 없습니다';
      AppLogger.e('아이템 삭제 실패', e, stackTrace);
      notifyListeners();
      return false;
    }
  }

  /// 우선순위 재정렬
  Future<void> reorderItems(int oldIndex, int newIndex) async {
    try {
      // 로컬 리스트 먼저 업데이트 (즉시 UI 반영)
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
      notifyListeners();

      // DB에 순서 저장
      final orderedIds = _items.map((item) => item.id).toList();
      await _repository.reorderItems(orderedIds);
      AppLogger.i('우선순위 재정렬 완료');
    } catch (e, stackTrace) {
      AppLogger.e('순서 변경 실패', e, stackTrace);
      await loadItems(); // 실패 시 원래 상태로 복구
    }
  }

  /// 총 예상 금액
  Future<int> getTotalPrice() async {
    try {
      return await _repository.getTotalPrice();
    } catch (e) {
      return 0;
    }
  }

  /// 카테고리별 필터링
  List<WishlistItem> getItemsByCategory(String categoryId) {
    return _items.where((item) => item.categoryId == categoryId).toList();
  }
}
