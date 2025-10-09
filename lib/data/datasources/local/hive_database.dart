import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/utils/logger.dart';
import '../../models/category.dart';
import '../../models/wishlist_item.dart';
import '../../models/owned_item.dart';

/// Hive 데이터베이스 초기화 및 관리
class HiveDatabase {
  HiveDatabase._();

  // Box 이름 상수
  static const String wishlistBoxName = 'wishlist_box';
  static const String ownedBoxName = 'owned_box';
  static const String categoryBoxName = 'category_box';
  static const String settingsBoxName = 'settings_box';

  /// Hive 초기화
  static Future<void> initialize() async {
    try {
      AppLogger.i('🗄️ Hive 초기화 시작...');

      // Hive 초기화
      await Hive.initFlutter();

      // TypeAdapter 등록
      _registerAdapters();

      AppLogger.i('✅ Hive 초기화 완료');
    } catch (e, stackTrace) {
      AppLogger.e('❌ Hive 초기화 실패', e, stackTrace);
      rethrow;
    }
  }

  /// TypeAdapter 등록
  static void _registerAdapters() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CategoryAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(WishlistItemAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(OwnedItemAdapter());
    }
    AppLogger.i('📝 TypeAdapter 등록 완료');
  }

  /// 모든 Box 열기
  static Future<void> openBoxes() async {
    try {
      AppLogger.i('📦 Box 열기 시작...');

      // 각 Box 열기
      await Future.wait([
        Hive.openBox(wishlistBoxName),
        Hive.openBox(ownedBoxName),
        Hive.openBox(categoryBoxName),
        Hive.openBox(settingsBoxName),
      ]);

      AppLogger.i('✅ 모든 Box 열기 완료');
    } catch (e, stackTrace) {
      AppLogger.e('❌ Box 열기 실패', e, stackTrace);
      rethrow;
    }
  }

  /// Wishlist Box 가져오기
  static Box getWishlistBox() {
    return Hive.box(wishlistBoxName);
  }

  /// Owned Box 가져오기
  static Box getOwnedBox() {
    return Hive.box(ownedBoxName);
  }

  /// Category Box 가져오기
  static Box getCategoryBox() {
    return Hive.box(categoryBoxName);
  }

  /// Settings Box 가져오기
  static Box getSettingsBox() {
    return Hive.box(settingsBoxName);
  }

  /// 모든 데이터 삭제 (개발/테스트용)
  static Future<void> clearAll() async {
    try {
      AppLogger.w('⚠️ 모든 데이터 삭제 시작...');

      await Future.wait([
        getWishlistBox().clear(),
        getOwnedBox().clear(),
        getCategoryBox().clear(),
        getSettingsBox().clear(),
      ]);

      AppLogger.i('✅ 모든 데이터 삭제 완료');
    } catch (e, stackTrace) {
      AppLogger.e('❌ 데이터 삭제 실패', e, stackTrace);
      rethrow;
    }
  }
}
