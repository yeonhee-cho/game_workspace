// lib/common/app_styles.dart
// 앱 전체 스타일 정의

import 'package:flutter/material.dart';

/*
 * AppColors 클래스 작성
 */
class AppColors {
  // 모든 색상 상수 정의하기
  // Primary Colors
  static const Color primary = Color(0xFF6200EE);
  static const Color secondary = Color(0xFF03DAC6);

  // Background Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;

  // Status Colors
  static const Color error = Color(0xFFB00020);

  // Text Colors
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF757575);
  static const Color grey500 = Color(0xFF9E9E9E);
}

/*
 * AppTextStyles 클래스 작성
 */
class AppTextStyles {
  // 모든 텍스트 스타일 정의하기
  static const TextStyle todoContent = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle todoCompleted = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.grey500,
    decoration: TextDecoration.lineThrough
  );

  static const TextStyle todoDate = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static const TextStyle statCount = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
}

/*
 * AppSpacing 클래스 작성
 * - sm: 8.0
 * - md: 16.0
 * - lg: 24.0
 */
class AppSpacing {
  // 간격 상수 정의하기
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
}

/*
 * AppRadius 클래스 작성
 * - md: 12.0
 * - mediumRadius getter: BorderRadius.circular(md) 반환
 */
class AppRadius {
  // radius 상수와 getter 정의하기
  static const double md = 12.0;

  // BorderRadius 객체
  static BorderRadius get mediumRadius => BorderRadius.circular(md);
}