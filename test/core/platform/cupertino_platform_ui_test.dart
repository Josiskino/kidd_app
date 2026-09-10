import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kid_app/core/platform/impl/cupertino_platform_ui.dart';
import 'package:kid_app/core/platform/platform_ui.dart';

void main() {
  test(
    'CupertinoShell configures a transparent Cupertino bottom navigation',
    () {
      final shell = const CupertinoShell();
      final widget = shell.buildMainShell(
        body: const SizedBox.shrink(),
        selectedIndex: 0,
        onSelected: (_) {},
        destinations: const [
          PlatformDestination(
            icon: CupertinoIcons.house,
            selectedIcon: CupertinoIcons.house_fill,
            cupertinoIcon: CupertinoIcons.house,
            cupertinoSelectedIcon: CupertinoIcons.house_fill,
            sfSymbol: 'house',
            selectedSfSymbol: 'house.fill',
            label: 'Home',
          ),
          PlatformDestination(
            icon: CupertinoIcons.compass,
            selectedIcon: CupertinoIcons.compass_fill,
            cupertinoIcon: CupertinoIcons.compass,
            cupertinoSelectedIcon: CupertinoIcons.compass_fill,
            sfSymbol: 'safari',
            selectedSfSymbol: 'safari.fill',
            label: 'Explore',
          ),
        ],
      );

      expect(widget, isA<AdaptiveScaffold>());

      final scaffold = widget as AdaptiveScaffold;
      expect(scaffold.bottomNavigationBar, isA<AdaptiveBottomNavigationBar>());

      final bottomNav = scaffold.bottomNavigationBar!;
      expect(bottomNav.useNativeBottomBar, isFalse);
      expect(bottomNav.cupertinoTabBar, isNotNull);

      expect(
        bottomNav.cupertinoTabBar!.backgroundColor,
        isSameColorAs(CupertinoColors.transparent),
      );
      expect(bottomNav.cupertinoTabBar!.border, isNull);
    },
  );

  test('CupertinoShell keeps page content below the native top chrome', () {
    final shell = const CupertinoShell();
    final widget = shell.buildPage(
      title: 'Kid App',
      body: const Text('Page body'),
    );

    expect(widget, isA<AdaptiveScaffold>());

    final scaffold = widget as AdaptiveScaffold;
    expect(scaffold.body, isA<SafeArea>());

    final safeArea = scaffold.body! as SafeArea;
    expect(safeArea.top, isTrue);
  });
}
