import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.concrete,
      primaryColor: AppColors.caution,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.caution,
        secondary: AppColors.rust,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      textTheme: TextTheme(
        bodyLarge: AppTextStyles.body(),
        bodyMedium: AppTextStyles.body(),
      ),
      dividerColor: AppColors.hairline,
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(AppColors.hairlineStrong),
      ),
      visualDensity: VisualDensity.standard,
    );
  }
}
