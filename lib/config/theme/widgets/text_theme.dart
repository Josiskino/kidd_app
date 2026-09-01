import 'package:flutter/material.dart';

import '../app_colors.dart';

enum KidFonts {
  title('SF Pro Display'),
  body('SF Pro Text');

  const KidFonts(this.value);
  final String value;
}

class KidTextTheme {
  const KidTextTheme._();

  static const List<String> fontFallbacks = [
    '.SF Pro Text',
    'Segoe UI Variable',
    'Segoe UI',
    'Roboto',
  ];

  static TextStyle titleStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
  }) {
    return TextStyle(
      fontFamily: KidFonts.title.value,
      fontFamilyFallback: fontFallbacks,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  static TextStyle bodyStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
  }) {
    return TextStyle(
      fontFamily: KidFonts.body.value,
      fontFamilyFallback: fontFallbacks,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  static TextTheme getTextTheme({required bool isDark}) {
    final text = isDark ? AppColors.textDark : AppColors.textLight;
    final subText = isDark ? AppColors.subTextDark : AppColors.subTextLight;

    return TextTheme(
      headlineLarge: titleStyle(
        color: text,
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: titleStyle(
        color: text,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: titleStyle(
        color: text,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: titleStyle(
        color: text,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: bodyStyle(
        color: text,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: bodyStyle(
        color: text,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: bodyStyle(color: text, fontSize: 16),
      bodyMedium: bodyStyle(color: text, fontSize: 14),
      bodySmall: bodyStyle(color: subText, fontSize: 12),
      labelLarge: bodyStyle(
        color: text,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      labelMedium: bodyStyle(
        color: subText,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
