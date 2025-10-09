import '../../data/models/category.dart';

/// 카테고리 Repository 인터페이스
abstract class CategoryRepository {
  /// 모든 카테고리 가져오기
  Future<List<Category>> getAllCategories();

  /// ID로 카테고리 가져오기
  Future<Category?> getCategoryById(String id);

  /// 카테고리 추가
  Future<void> addCategory(Category category);

  /// 카테고리 업데이트
  Future<void> updateCategory(Category category);

  /// 카테고리 삭제
  Future<void> deleteCategory(String id);

  /// 기본 카테고리 초기화
  Future<void> initializeDefaultCategories();
}
