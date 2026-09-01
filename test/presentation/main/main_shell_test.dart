import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:kid_app/app.dart';
import 'package:kid_app/core/platform/app_platform.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('Android main shell renders Material destinations', (
    tester,
  ) async {
    await tester.pumpWithPlatform(
      platform: AppPlatform.android,
      child: const KidApp(),
    );

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(3));
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('iOS main shell renders Cupertino tab items', (tester) async {
    await tester.pumpWithPlatform(
      platform: AppPlatform.ios,
      child: const KidApp(),
    );

    expect(find.byType(AdaptiveScaffold), findsWidgets);
    expect(find.byType(CupertinoTabScaffold), findsNothing);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
