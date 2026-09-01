import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kid_app/app.dart';
import 'package:kid_app/core/platform/app_platform.dart';

import 'helpers/test_app.dart';

void main() {
  testWidgets('KidApp renders the home screen', (tester) async {
    await tester.pumpWithPlatform(
      platform: AppPlatform.android,
      child: const KidApp(),
    );

    expect(find.text('Kid App'), findsOneWidget);
    expect(find.text('Home foundation'), findsOneWidget);
  });

  testWidgets('Android platform uses a Material page shell', (tester) async {
    await tester.pumpWithPlatform(
      platform: AppPlatform.android,
      child: const KidApp(),
    );

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsWidgets);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(CupertinoPageScaffold), findsNothing);
  });

  testWidgets('iOS platform uses a Cupertino page shell', (tester) async {
    await tester.pumpWithPlatform(
      platform: AppPlatform.ios,
      child: const KidApp(),
    );

    expect(find.byType(CupertinoApp), findsOneWidget);
    expect(find.byType(CupertinoTabScaffold), findsOneWidget);
    expect(find.byType(CupertinoTabBar), findsOneWidget);
    expect(find.byType(CupertinoPageScaffold), findsOneWidget);
    expect(find.byType(CupertinoNavigationBar), findsOneWidget);
    expect(find.byType(AppBar), findsNothing);
  });

  testWidgets('Main navigation switches tabs on Android', (tester) async {
    await tester.pumpWithPlatform(
      platform: AppPlatform.android,
      child: const KidApp(),
    );

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Profile foundation'), findsOneWidget);
  });
}
