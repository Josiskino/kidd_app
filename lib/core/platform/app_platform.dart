import 'package:flutter/foundation.dart';

enum AppPlatform {
  android,
  ios,
  macos,
  windows;

  bool get isMobile => this == android || this == ios;
  bool get isApple => this == ios || this == macos;

  static AppPlatform fromTarget(TargetPlatform target) {
    return switch (target) {
      TargetPlatform.android => AppPlatform.android,
      TargetPlatform.iOS => AppPlatform.ios,
      TargetPlatform.macOS => AppPlatform.macos,
      TargetPlatform.windows => AppPlatform.windows,
      TargetPlatform.linux || TargetPlatform.fuchsia => AppPlatform.android,
    };
  }

  static AppPlatform get current {
    const forced = String.fromEnvironment('FORCE_PLATFORM');
    if (forced.isNotEmpty) {
      for (final platform in AppPlatform.values) {
        if (platform.name == forced) return platform;
      }
    }

    return fromTarget(defaultTargetPlatform);
  }
}
