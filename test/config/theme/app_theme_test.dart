import 'package:flutter_test/flutter_test.dart';
import 'package:kid_app/config/theme/app_colors.dart';
import 'package:kid_app/config/theme/cupertino_theme.dart';
import 'package:kid_app/config/theme/theme.dart';

void main() {
  test('Material light and dark themes use readable surface colors', () {
    final light = KidAppTheme.lightThemeData();
    final dark = KidAppTheme.darkThemeData();

    expect(light.colorScheme.surface, AppColors.surfaceLight);
    expect(light.colorScheme.onSurface, AppColors.textLight);
    expect(dark.colorScheme.surface, AppColors.surfaceDark);
    expect(dark.colorScheme.onSurface, AppColors.textDark);
  });

  test('Cupertino themes share the same primary brand color', () {
    expect(KidCupertinoTheme.lightTheme.primaryColor, AppColors.primaryLight);
    expect(KidCupertinoTheme.darkTheme.primaryColor, AppColors.primaryDark);
  });
}
