import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kid_app/core/platform/app_platform.dart';
import 'package:kid_app/core/platform/platform_ui_provider.dart';

extension PlatformPump on WidgetTester {
  Future<void> pumpWithPlatform({
    required AppPlatform platform,
    required Widget child,
  }) {
    return pumpWidget(
      ProviderScope(
        overrides: [appPlatformProvider.overrideWithValue(platform)],
        child: child,
      ),
    );
  }
}
