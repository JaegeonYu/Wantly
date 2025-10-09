import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/repositories/category_repository.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/logger.dart';
import '../datasources/local/hive_database.dart';
import '../models/category.dart';

/// 카테고리 Repository 구현체
class CategoryRepositoryImpl implements CategoryRepository {
  final _uuid = const Uuid();

  @override
  Future<List<Category>> getAllCategories() async {
    try {
      final box = HiveDatabase.getCategoryBox();
      final categories = box.values.cast<Category>().toList();

      // orderIndex로 정렬
      categories.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

      return categories;
    } catch (e, stackTrace) {
      AppLogger.e('카테고리 목록 가져오기 실패', e, stackTrace);
      return [];
    }
  }

  @override
  Future<Category?> getCategoryById(String id) async {
    try {
      final box = HiveDatabase.getCategoryBox();
      return box.get(id) as Category?;
    } catch (e, stackTrace) {
      AppLogger.e('카테고리 가져오기 실패: $id', e, stackTrace);
      return null;
    }
  }

  @override
  Future<void> addCategory(Category category) async {
    try {
      final box = HiveDatabase.getCategoryBox();
      await box.put(category.id, category);
      AppLogger.i('카테고리 추가: ${category.name}');
    } catch (e, stackTrace) {
      AppLogger.e('카테고리 추가 실패', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> updateCategory(Category category) async {
    try {
      final box = HiveDatabase.getCategoryBox();
      await box.put(category.id, category);
      AppLogger.i('카테고리 업데이트: ${category.name}');
    } catch (e, stackTrace) {
      AppLogger.e('카테고리 업데이트 실패', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      final box = HiveDatabase.getCategoryBox();
      await box.delete(id);
      AppLogger.i('카테고리 삭제: $id');
    } catch (e, stackTrace) {
      AppLogger.e('카테고리 삭제 실패', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> initializeDefaultCategories() async {
    try {
      final box = HiveDatabase.getCategoryBox();

      // 이미 카테고리가 있으면 초기화하지 않음
      if (box.isNotEmpty) {
        AppLogger.i('카테고리가 이미 존재합니다');
        return;
      }

      // 기본 카테고리 생성
      final defaultCategories = [
        Category(
          id: _uuid.v4(),
          name: AppStrings.categoryElectronics,
          iconCode: Icons.laptop.codePoint,
          colorValue: AppColors.categoryElectronics.value,
          orderIndex: 0,
        ),
        Category(
          id: _uuid.v4(),
          name: AppStrings.categoryFashion,
          iconCode: Icons.checkroom.codePoint,
          colorValue: AppColors.categoryFashion.value,
          orderIndex: 1,
        ),
        Category(
          id: _uuid.v4(),
          name: AppStrings.categoryHobby,
          iconCode: Icons.sports_esports.codePoint,
          colorValue: AppColors.categoryHobby.value,
          orderIndex: 2,
        ),
        Category(
          id: _uuid.v4(),
          name: AppStrings.categoryBook,
          iconCode: Icons.menu_book.codePoint,
          colorValue: AppColors.categoryBook.value,
          orderIndex: 3,
        ),
        Category(
          id: _uuid.v4(),
          name: AppStrings.categoryHome,
          iconCode: Icons.home.codePoint,
          colorValue: AppColors.categoryHome.value,
          orderIndex: 4,
        ),
        Category(
          id: _uuid.v4(),
          name: AppStrings.categoryEtc,
          iconCode: Icons.more_horiz.codePoint,
          colorValue: AppColors.categoryEtc.value,
          orderIndex: 5,
        ),
      ];

      // 모든 카테고리 저장
      for (final category in defaultCategories) {
        await box.put(category.id, category);
      }

      AppLogger.i('✅ 기본 카테고리 ${defaultCategories.length}개 초기화 완료');
    } catch (e, stackTrace) {
      AppLogger.e('기본 카테고리 초기화 실패', e, stackTrace);
      rethrow;
    }
  }
}
