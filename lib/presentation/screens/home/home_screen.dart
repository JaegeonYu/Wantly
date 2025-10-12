import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/insight_provider.dart';
import '../../providers/owned_provider.dart';
import '../../providers/wishlist_provider.dart';
import '../wishlist/wishlist_screen.dart';
import '../owned/owned_screen.dart';
import '../insight/insight_screen.dart';

/// 홈 화면 (탭 네비게이션)
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    WishlistScreen(),
    OwnedScreen(),
    InsightScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          // 탭 전환 시 데이터 갱신
          _refreshTabData(index);
        },
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey500,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: '위시리스트',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: '구매 목록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights_outlined),
            activeIcon: Icon(Icons.insights),
            label: '인사이트',
          ),
        ],
      ),
    );
  }

  /// 탭 전환 시 데이터 갱신
  void _refreshTabData(int index) {
    switch (index) {
      case 0: // 위시리스트
        context.read<WishlistProvider>().loadItems();
        break;
      case 1: // 구매 목록
        context.read<OwnedProvider>().loadItems();
        break;
      case 2: // 인사이트
        context.read<InsightProvider>().loadData();
        break;
    }
  }
}
