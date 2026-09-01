import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/theme/cupertino_theme.dart';
import 'config/theme/theme.dart';
import 'core/platform/app_platform.dart';
import 'core/platform/platform_ui_provider.dart';
import 'presentation/pages/home/home_screen.dart';

class KidApp extends ConsumerWidget {
  const KidApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platform = ref.watch(appPlatformProvider);

    if (platform == AppPlatform.ios) {
      return CupertinoApp(
        title: 'Kid App',
        theme: KidCupertinoTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      );
    }

    return MaterialApp(
      title: 'Kid App',
      theme: KidAppTheme.lightThemeData(),
      darkTheme: KidAppTheme.darkThemeData(),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
