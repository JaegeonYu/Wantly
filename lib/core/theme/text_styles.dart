import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// WANTLY 앱의 텍스트 스타일
class AppTextStyles {
  AppTextStyles._();

  // ========== Headings (제목) ==========

  /// H1 - 가장 큰 제목 (예: 화면 타이틀)
  static const TextStyle h1 = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    height: 1.2,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  /// H2 - 섹션 제목
  static const TextStyle h2 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    height: 1.3,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  /// H3 - 카드 제목
  static const TextStyle h3 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// H4 - 작은 제목
  static const TextStyle h4 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  // ========== Body Text (본문) ==========

  /// Body1 - 기본 본문
  static const TextStyle body1 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  /// Body2 - 작은 본문
  static const TextStyle body2 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: AppColors.textSecondary,
  );

  /// Body Bold - 강조된 본문
  static const TextStyle bodyBold = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  // ========== Caption (작은 텍스트) ==========

  /// Caption - 보조 설명 텍스트
  static const TextStyle caption = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    height: 1.4,
    color: AppColors.textSecondary,
  );

  /// Caption Bold
  static const TextStyle captionBold = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.textSecondary,
  );

  // ========== Button Text ==========

  /// Button - 버튼 텍스트
  static const TextStyle button = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.5,
  );

  /// Button Small - 작은 버튼 텍스트
  static const TextStyle buttonSmall = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.3,
  );

  // ========== Price (가격) ==========

  /// Price Large - 큰 가격 표시
  static const TextStyle priceLarge = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    height: 1.2,
    color: AppColors.primary,
  );

  /// Price Medium - 중간 가격 표시
  static const TextStyle priceMedium = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: AppColors.primary,
  );

  /// Price Small - 작은 가격 표시
  static const TextStyle priceSmall = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: AppColors.primary,
  );

  // ========== Special ==========

  /// Link - 링크 텍스트
  static const TextStyle link = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    height: 1.4,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );

  /// Error - 에러 메시지
  static const TextStyle error = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    height: 1.4,
    color: AppColors.error,
  );

  /// Label - 폼 라벨
  static const TextStyle label = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.textSecondary,
  );
}
