import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/logger.dart';
import 'data/datasources/local/hive_database.dart';
import 'data/repositories/category_repository_impl.dart';
import 'presentation/providers/wishlist_provider.dart';
import 'presentation/providers/owned_provider.dart';
import 'presentation/providers/insight_provider.dart';
import 'presentation/screens/home/home_screen.dart';

void main() async {
  // Flutter 바인딩 초기화
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // 스플래시 화면 유지
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Hive 데이터베이스 초기화
  await _initializeApp();

  // 스플래시 화면 제거
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

/// 앱 초기화
Future<void> _initializeApp() async {
  try {
    AppLogger.i('🚀 WANTLY 앱 초기화 시작');

    // Hive 초기화
    await HiveDatabase.initialize();
    await HiveDatabase.openBoxes();

    // 기본 카테고리 초기화
    final categoryRepository = CategoryRepositoryImpl();
    await categoryRepository.initializeDefaultCategories();

    AppLogger.i('✅ WANTLY 앱 초기화 완료');
  } catch (e, stackTrace) {
    AppLogger.e('❌ 앱 초기화 실패', e, stackTrace);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => OwnedProvider()),
        ChangeNotifierProvider(create: (_) => InsightProvider()),
      ],
      child: MaterialApp(
        title: 'WANTLY',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: const HomeScreen(),
      ),
    );
  }
}
