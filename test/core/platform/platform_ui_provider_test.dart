import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kid_app/core/platform/app_platform.dart';
import 'package:kid_app/core/platform/impl/cupertino_platform_ui.dart';
import 'package:kid_app/core/platform/impl/material_platform_ui.dart';
import 'package:kid_app/core/platform/platform_ui_provider.dart';

void main() {
  test('platformUiProvider resolves Material UI for Android', () {
    final container = ProviderContainer(
      overrides: [appPlatformProvider.overrideWithValue(AppPlatform.android)],
    );
    addTearDown(container.dispose);

    expect(container.read(platformUiProvider), isA<MaterialPlatformUi>());
  });

  test('platformUiProvider resolves Cupertino UI for iOS', () {
    final container = ProviderContainer(
      overrides: [appPlatformProvider.overrideWithValue(AppPlatform.ios)],
    );
    addTearDown(container.dispose);

    expect(container.read(platformUiProvider), isA<CupertinoPlatformUi>());
  });
}
