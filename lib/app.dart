import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/theme/cupertino_theme.dart';
import 'config/theme/theme.dart';
import 'core/platform/app_platform.dart';
import 'core/platform/platform_ui_provider.dart';
import 'presentation/main/main_shell.dart';

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
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('fr')],
        home: const MainShell(),
      );
    }

    return MaterialApp(
      title: 'Kid App',
      theme: KidAppTheme.lightThemeData(),
      darkTheme: KidAppTheme.darkThemeData(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('fr')],
      home: const MainShell(),
    );
  }
}
