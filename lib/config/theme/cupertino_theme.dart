import 'package:flutter/cupertino.dart';

import 'app_colors.dart';
import 'widgets/text_theme.dart';

class KidCupertinoTheme {
  const KidCupertinoTheme._();

  static CupertinoThemeData get lightTheme => CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryLight,
    primaryContrastingColor: CupertinoColors.white,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    barBackgroundColor: AppColors.appBarLight,
    applyThemeToAll: true,
    textTheme: _textTheme(isDark: false),
  );

  static CupertinoThemeData get darkTheme => CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    primaryContrastingColor: CupertinoColors.black,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    barBackgroundColor: AppColors.appBarDark,
    applyThemeToAll: true,
    textTheme: _textTheme(isDark: true),
  );

  static CupertinoTextThemeData _textTheme({required bool isDark}) {
    final text = isDark ? AppColors.textDark : AppColors.textLight;
    final primary = isDark ? AppColors.primaryDark : AppColors.primaryLight;

    return CupertinoTextThemeData(
      primaryColor: primary,
      textStyle: KidTextTheme.bodyStyle(fontSize: 17, color: text),
      actionTextStyle: KidTextTheme.bodyStyle(fontSize: 17, color: primary),
      navTitleTextStyle: KidTextTheme.titleStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: text,
      ),
      navLargeTitleTextStyle: KidTextTheme.titleStyle(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        color: text,
      ),
      tabLabelTextStyle: KidTextTheme.bodyStyle(fontSize: 10, color: text),
    );
  }
}
