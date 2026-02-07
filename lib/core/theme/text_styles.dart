import 'package:flutter/material.dart';
import 'app_colors.dart';

class TextStyles {
  TextStyles._();

  // Headings
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textSecondary,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textSecondary,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textSecondary,
  );

  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // App Bar
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Arabic Text
  static const TextStyle arabic = TextStyle(
    fontFamily: 'arabic1',
    fontSize: 24,
    fontWeight: FontWeight.normal,
  );

  // Bangla Text
  static const TextStyle bangla = TextStyle(
    fontFamily: 'bangla1',
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
}
