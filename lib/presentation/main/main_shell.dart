import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/theme/app_colors.dart';
import '../../core/platform/platform_ui_provider.dart';
import '../../core/providers/navigation/main_tab_provider.dart';
import '../pages/home/home_screen.dart';
import '../pages/placeholder/placeholder_section_screen.dart';
import 'nav_destinations.dart';

class MainShell extends ConsumerWidget {
  const MainShell({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    PlaceholderSectionScreen(
      title: 'Explore',
      headline: 'Explore foundation',
      body: 'This tab will host discovery and activity screens later.',
    ),
    PlaceholderSectionScreen(
      title: 'Profile',
      headline: 'Profile foundation',
      body: 'This tab will host account and child profile screens later.',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platformUi = ref.watch(platformUiProvider);
    final selectedIndex = ref.watch(mainTabProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final destinations = [
      for (final destination in NavDestinations.all)
        destination.toPlatformDestination(),
    ];

    return platformUi.shell.buildMainShell(
      body: IndexedStack(index: selectedIndex, children: _screens),
      destinations: destinations,
      selectedIndex: selectedIndex,
      onSelected: (index) => ref.read(mainTabProvider.notifier).select(index),
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
    );
  }
}
