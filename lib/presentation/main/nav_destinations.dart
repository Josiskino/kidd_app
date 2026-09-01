import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/platform/platform_ui.dart';

class NavDestinationSpec {
  const NavDestinationSpec({
    required this.index,
    required this.icon,
    required this.selectedIcon,
    required this.cupertinoIcon,
    required this.cupertinoSelectedIcon,
    required this.label,
  });

  final int index;
  final IconData icon;
  final IconData selectedIcon;
  final IconData cupertinoIcon;
  final IconData cupertinoSelectedIcon;
  final String label;

  PlatformDestination toPlatformDestination() {
    return PlatformDestination(
      key: ValueKey('main-nav-$index-$label'),
      icon: icon,
      selectedIcon: selectedIcon,
      cupertinoIcon: cupertinoIcon,
      cupertinoSelectedIcon: cupertinoSelectedIcon,
      label: label,
    );
  }
}

abstract final class NavDestinations {
  static const List<NavDestinationSpec> all = [
    NavDestinationSpec(
      index: 0,
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      cupertinoIcon: CupertinoIcons.house,
      cupertinoSelectedIcon: CupertinoIcons.house_fill,
      label: 'Home',
    ),
    NavDestinationSpec(
      index: 1,
      icon: Icons.explore_outlined,
      selectedIcon: Icons.explore,
      cupertinoIcon: CupertinoIcons.compass,
      cupertinoSelectedIcon: CupertinoIcons.compass_fill,
      label: 'Explore',
    ),
    NavDestinationSpec(
      index: 2,
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      cupertinoIcon: CupertinoIcons.person,
      cupertinoSelectedIcon: CupertinoIcons.person_fill,
      label: 'Profile',
    ),
  ];
}
