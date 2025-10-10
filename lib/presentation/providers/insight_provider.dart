import 'package:flutter/foundation.dart';
import '../../core/utils/logger.dart';
import '../../data/models/owned_item.dart';
import '../../data/models/category.dart' as models;
import '../../data/repositories/owned_repository_impl.dart';
import '../../data/repositories/category_repository_impl.dart';

/// 인사이트 화면 Provider
class InsightProvider extends ChangeNotifier {
  final _ownedRepository = OwnedRepositoryImpl();
  final _categoryRepository = CategoryRepositoryImpl();

  bool _isLoading = false;
  String? _errorMessage;

  List<OwnedItem> _allItems = [];
  List<models.Category> _categories = [];

  // 필터
  InsightPeriod _selectedPeriod = InsightPeriod.thisYear;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  InsightPeriod get selectedPeriod => _selectedPeriod;
  List<OwnedItem> get filteredItems => _getFilteredItems();

  /// 데이터 로드
  Future<void> loadData() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      AppLogger.i('📊 인사이트 데이터 로드 시작');

      // Repository에서 데이터 로드
      _allItems = await _ownedRepository.getAllItems();
      _categories = await _categoryRepository.getAllCategories();

      AppLogger.i('📊 인사이트 데이터 로드 완료: ${_allItems.length}개 아이템');

      _isLoading = false;
      notifyListeners();
    } catch (e, stackTrace) {
      AppLogger.e('❌ 인사이트 데이터 로드 실패', e, stackTrace);
      _errorMessage = '데이터를 불러오는데 실패했습니다.';
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 기간 필터 변경
  void setPeriod(InsightPeriod period) {
    _selectedPeriod = period;
    notifyListeners();
  }

  /// 필터링된 아이템 가져오기
  List<OwnedItem> _getFilteredItems() {
    final now = DateTime.now();
    DateTime startDate;

    switch (_selectedPeriod) {
      case InsightPeriod.thisYear:
        startDate = DateTime(now.year, 1, 1);
        break;
      case InsightPeriod.last6Months:
        startDate = DateTime(now.year, now.month - 6, now.day);
        break;
      case InsightPeriod.last3Months:
        startDate = DateTime(now.year, now.month - 3, now.day);
        break;
      case InsightPeriod.all:
        return _allItems;
    }

    return _allItems
        .where((item) => item.purchaseDate.isAfter(startDate))
        .toList();
  }

  /// 총 지출액
  int getTotalSpent() {
    return filteredItems.fold(0, (sum, item) => sum + item.actualPrice);
  }

  /// 평균 만족도
  double getAverageSatisfaction() {
    if (filteredItems.isEmpty) return 0.0;
    final total = filteredItems.fold(
      0.0,
      (sum, item) => sum + item.satisfactionScore,
    );
    return total / filteredItems.length;
  }

  /// 구매 횟수
  int getPurchaseCount() {
    return filteredItems.length;
  }

  /// 월별 지출 데이터 (최근 12개월)
  Map<int, int> getMonthlySpending() {
    final now = DateTime.now();
    final monthlyData = <int, int>{};

    // 최근 12개월 초기화
    for (int i = 11; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i, 1).month;
      monthlyData[month] = 0;
    }

    // 데이터 집계
    for (final item in filteredItems) {
      final month = item.purchaseDate.month;
      if (monthlyData.containsKey(month)) {
        monthlyData[month] = monthlyData[month]! + item.actualPrice;
      }
    }

    return monthlyData;
  }

  /// 카테고리별 지출 비율
  Map<String, CategorySpending> getCategorySpending() {
    final result = <String, CategorySpending>{};

    for (final category in _categories) {
      final items = filteredItems
          .where((item) => item.categoryId == category.id)
          .toList();

      if (items.isNotEmpty) {
        final totalSpent = items.fold(0, (sum, item) => sum + item.actualPrice);
        final avgSatisfaction =
            items.fold(0.0, (sum, item) => sum + item.satisfactionScore) /
            items.length;

        result[category.id] = CategorySpending(
          category: category,
          totalSpent: totalSpent,
          itemCount: items.length,
          averageSatisfaction: avgSatisfaction,
        );
      }
    }

    return result;
  }

  /// 베스트 구매 (만족도 높은 순)
  List<OwnedItem> getBestPurchases({int limit = 3}) {
    final sorted = List<OwnedItem>.from(filteredItems)
      ..sort((a, b) => b.satisfactionScore.compareTo(a.satisfactionScore));
    return sorted.take(limit).toList();
  }

  /// 워스트 구매 (만족도 낮은 순)
  List<OwnedItem> getWorstPurchases({int limit = 3}) {
    final sorted = List<OwnedItem>.from(filteredItems)
      ..sort((a, b) => a.satisfactionScore.compareTo(b.satisfactionScore));
    return sorted.take(limit).toList();
  }

  /// 가성비 베스트 (만족도/가격)
  List<OwnedItem> getBestValuePurchases({int limit = 3}) {
    final sorted = List<OwnedItem>.from(filteredItems)
      ..sort((a, b) => b.valueForMoney.compareTo(a.valueForMoney));
    return sorted.take(limit).toList();
  }

  /// 카테고리 정보 가져오기
  models.Category? getCategoryById(String categoryId) {
    try {
      return _categories.firstWhere((c) => c.id == categoryId);
    } catch (e) {
      return null;
    }
  }
}

/// 인사이트 기간
enum InsightPeriod { thisYear, last6Months, last3Months, all }

extension InsightPeriodExtension on InsightPeriod {
  String get label {
    switch (this) {
      case InsightPeriod.thisYear:
        return '올해';
      case InsightPeriod.last6Months:
        return '최근 6개월';
      case InsightPeriod.last3Months:
        return '최근 3개월';
      case InsightPeriod.all:
        return '전체';
    }
  }
}

/// 카테고리별 지출 정보
class CategorySpending {
  final models.Category category;
  final int totalSpent;
  final int itemCount;
  final double averageSatisfaction;

  CategorySpending({
    required this.category,
    required this.totalSpent,
    required this.itemCount,
    required this.averageSatisfaction,
  });

  double getPercentage(int totalSpending) {
    if (totalSpending == 0) return 0;
    return (totalSpent / totalSpending) * 100;
  }
}
