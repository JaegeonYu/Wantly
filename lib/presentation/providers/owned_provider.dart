import 'package:flutter/material.dart';
import '../../data/models/owned_item.dart';
import '../../data/repositories/owned_repository_impl.dart';
import '../../domain/repositories/owned_repository.dart';
import '../../core/utils/logger.dart';

/// 구매 완료 아이템 상태 관리 Provider
class OwnedProvider extends ChangeNotifier {
  final OwnedRepository _repository = OwnedRepositoryImpl();

  List<OwnedItem> _items = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<OwnedItem> get items => _items;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isEmpty => _items.isEmpty;
  int get itemCount => _items.length;

  /// 구매 아이템 불러오기
  Future<void> loadItems() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _items = await _repository.getAllItems();
      AppLogger.i('구매 아이템 ${_items.length}개 로드 완료');

      _isLoading = false;
      notifyListeners();
    } catch (e, stackTrace) {
      _isLoading = false;
      _errorMessage = '구매 목록을 불러올 수 없습니다';
      AppLogger.e('구매 목록 로드 실패', e, stackTrace);
      notifyListeners();
    }
  }

  /// 아이템 추가
  Future<bool> addItem(OwnedItem item) async {
    try {
      await _repository.addItem(item);
      await loadItems();
      AppLogger.i('구매 아이템 추가: ${item.name}');
      return true;
    } catch (e, stackTrace) {
      _errorMessage = '아이템을 추가할 수 없습니다';
      AppLogger.e('구매 아이템 추가 실패', e, stackTrace);
      notifyListeners();
      return false;
    }
  }

  /// 아이템 업데이트
  Future<bool> updateItem(OwnedItem item) async {
    try {
      await _repository.updateItem(item);
      await loadItems();
      AppLogger.i('구매 아이템 업데이트: ${item.name}');
      return true;
    } catch (e, stackTrace) {
      _errorMessage = '아이템을 수정할 수 없습니다';
      AppLogger.e('구매 아이템 업데이트 실패', e, stackTrace);
      notifyListeners();
      return false;
    }
  }

  /// 아이템 삭제
  Future<bool> deleteItem(String id) async {
    try {
      await _repository.deleteItem(id);
      await loadItems();
      AppLogger.i('구매 아이템 삭제: $id');
      return true;
    } catch (e, stackTrace) {
      _errorMessage = '아이템을 삭제할 수 없습니다';
      AppLogger.e('구매 아이템 삭제 실패', e, stackTrace);
      notifyListeners();
      return false;
    }
  }

  /// 만족도 순서로 재정렬
  Future<void> reorderItems(int oldIndex, int newIndex) async {
    try {
      // 로컬 리스트 먼저 업데이트
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
      notifyListeners();

      // DB에 순서 저장
      final orderedIds = _items.map((item) => item.id).toList();
      await _repository.reorderBySatisfaction(orderedIds);
      AppLogger.i('구매 아이템 순서 변경 완료');
    } catch (e, stackTrace) {
      AppLogger.e('순서 변경 실패', e, stackTrace);
      await loadItems();
    }
  }

  /// 총 지출 금액
  Future<int> getTotalSpent() async {
    try {
      return await _repository.getTotalSpent();
    } catch (e) {
      return 0;
    }
  }

  /// 평균 만족도
  Future<double> getAverageSatisfaction() async {
    try {
      return await _repository.getAverageSatisfaction();
    } catch (e) {
      return 0.0;
    }
  }

  /// 카테고리별 필터링
  List<OwnedItem> getItemsByCategory(String categoryId) {
    return _items.where((item) => item.categoryId == categoryId).toList();
  }

  /// 만족도별 필터링
  List<OwnedItem> getItemsBySatisfaction(int minScore) {
    return _items.where((item) => item.satisfactionScore >= minScore).toList();
  }
}
