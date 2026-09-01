import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_platform.dart';
import 'impl/cupertino_platform_ui.dart';
import 'impl/material_platform_ui.dart';
import 'platform_ui.dart';

final appPlatformProvider = Provider<AppPlatform>((ref) => AppPlatform.current);

final platformUiProvider = Provider<PlatformUi>((ref) {
  final platform = ref.watch(appPlatformProvider);

  return switch (platform) {
    AppPlatform.ios => const CupertinoPlatformUi(),
    AppPlatform.android ||
    AppPlatform.macos ||
    AppPlatform.windows => MaterialPlatformUi(platform),
  };
});
