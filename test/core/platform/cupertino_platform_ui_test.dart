import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kid_app/core/platform/impl/cupertino_platform_ui.dart';
import 'package:kid_app/core/platform/platform_ui.dart';

void main() {
  test('CupertinoShell configures adaptive native bottom navigation', () {
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
      ],
    );

    expect(widget, isA<AdaptiveScaffold>());

    final scaffold = widget as AdaptiveScaffold;
    expect(scaffold.bottomNavigationBar, isA<AdaptiveBottomNavigationBar>());
    expect(scaffold.bottomNavigationBar!.useNativeBottomBar, isTrue);
  });
}
