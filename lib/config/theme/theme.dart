import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'design_tokens.dart';
import 'widgets/text_theme.dart';

class KidAppTheme {
  const KidAppTheme._();

  static ThemeData _base(Brightness brightness) {
    return ThemeData(
      brightness: brightness,
      useMaterial3: true,
      fontFamily: KidFonts.body.value,
      fontFamilyFallback: KidTextTheme.fontFallbacks,
    );
  }

  static ThemeData lightThemeData() {
    final base = _base(Brightness.light);
    final textTheme = base.textTheme.merge(
      KidTextTheme.getTextTheme(isDark: false),
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.backgroundLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.appBarLight,
        foregroundColor: AppColors.textLight,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppColors.textLight,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      textTheme: textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size.fromHeight(DesignTokens.heightButton),
          backgroundColor: AppColors.primaryLight,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          borderSide: BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          borderSide: BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryLight,
        onPrimary: Colors.white,
        secondary: AppColors.accentLight,
        onSecondary: AppColors.textLight,
        tertiary: AppColors.successLight,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.textLight,
        error: Color(0xFFD84A4A),
      ),
    );
  }

  static ThemeData darkThemeData() {
    final base = _base(Brightness.dark);
    final textTheme = base.textTheme.merge(
      KidTextTheme.getTextTheme(isDark: true),
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.backgroundDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.appBarDark,
        foregroundColor: AppColors.textDark,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppColors.textDark,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      textTheme: textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size.fromHeight(DesignTokens.heightButton),
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.backgroundDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          borderSide: BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          borderSide: BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          borderSide: const BorderSide(color: AppColors.primaryDark, width: 2),
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDark,
        onPrimary: AppColors.backgroundDark,
        secondary: AppColors.accentDark,
        onSecondary: AppColors.backgroundDark,
        tertiary: AppColors.successDark,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textDark,
        error: Color(0xFFFF8A8A),
      ),
    );
  }
}
