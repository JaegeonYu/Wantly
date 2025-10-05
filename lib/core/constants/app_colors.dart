import 'package:flutter/material.dart';

/// WANTLY 앱의 색상 시스템
class AppColors {
  // Private constructor - 인스턴스 생성 방지
  AppColors._();

  // ========== Primary Colors ==========
  static const Color primary = Color(0xFF6C63FF); // 보라색 (메인 브랜드)
  static const Color primaryLight = Color(0xFF9D97FF);
  static const Color primaryDark = Color(0xFF4B42E0);

  // ========== Secondary Colors ==========
  static const Color secondary = Color(0xFFFF6584); // 핑크색 (강조)
  static const Color secondaryLight = Color(0xFFFF95AA);
  static const Color secondaryDark = Color(0xFFE04560);

  // ========== Background Colors ==========
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F3F5);

  // ========== Text Colors ==========
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textTertiary = Color(0xFFADB5BD);
  static const Color textDisabled = Color(0xFFCED4DA);

  // ========== Status Colors ==========
  static const Color success = Color(0xFF51CF66);
  static const Color warning = Color(0xFFFFD43B);
  static const Color error = Color(0xFFFF6B6B);
  static const Color info = Color(0xFF4DABF7);

  // ========== Category Colors ==========
  static const Color categoryElectronics = Color(0xFF4DABF7); // 전자기기 - 파란색
  static const Color categoryFashion = Color(0xFFFF6584); // 패션 - 핑크색
  static const Color categoryHobby = Color(0xFF9D97FF); // 취미 - 보라색
  static const Color categoryBook = Color(0xFF51CF66); // 책/교육 - 초록색
  static const Color categoryHome = Color(0xFFFFA94D); // 생활용품 - 주황색
  static const Color categoryEtc = Color(0xFF868E96); // 기타 - 회색

  // ========== Satisfaction Colors (만족도) ==========
  static const Color satisfactionHigh = Color(0xFF51CF66); // 높음 - 초록색
  static const Color satisfactionMedium = Color(0xFFFFD43B); // 중간 - 노란색
  static const Color satisfactionLow = Color(0xFFFF6B6B); // 낮음 - 빨간색

  // ========== Neutral Colors ==========
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFF8F9FA);
  static const Color grey100 = Color(0xFFF1F3F5);
  static const Color grey200 = Color(0xFFE9ECEF);
  static const Color grey300 = Color(0xFFDEE2E6);
  static const Color grey400 = Color(0xFFCED4DA);
  static const Color grey500 = Color(0xFFADB5BD);
  static const Color grey600 = Color(0xFF868E96);
  static const Color grey700 = Color(0xFF495057);
  static const Color grey800 = Color(0xFF343A40);
  static const Color grey900 = Color(0xFF212529);

  // ========== Overlay Colors ==========
  static const Color overlay = Color(0x40000000); // 반투명 검정
  static const Color overlayLight = Color(0x20000000);
  static const Color overlayDark = Color(0x60000000);

  // ========== Dark Mode Colors (Optional) ==========
  static const Color darkBackground = Color(0xFF1A1A1A);
  static const Color darkSurface = Color(0xFF2D2D2D);
  static const Color darkTextPrimary = Color(0xFFE9ECEF);
}
