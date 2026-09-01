import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/design_tokens.dart';
import '../../../core/platform/platform_ui_provider.dart';
import '../../widgets/common/platform_page.dart';

final demoToggleProvider = NotifierProvider<DemoToggleNotifier, bool>(
  DemoToggleNotifier.new,
);

class DemoToggleNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void setEnabled(bool value) => state = value;
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platformUi = ref.watch(platformUiProvider);
    final enabled = ref.watch(demoToggleProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return PlatformPage(
      title: 'Kid App',
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: ListView(
        padding: DesignTokens.pagePadding,
        children: [
          Text('Front foundation', style: theme.textTheme.headlineMedium),
          const SizedBox(height: DesignTokens.spaceS),
          Text(
            'Theme, platform controls, and page shells are ready before data and domain layers arrive.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: DesignTokens.spaceXxl),
          _DemoSurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Icon(CupertinoIcons.device_phone_portrait),
                    const SizedBox(width: DesignTokens.spaceM),
                    Expanded(
                      child: Text(
                        platformUi.platform.name,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    platformUi.controls.switchToggle(
                      value: enabled,
                      onChanged: (value) => ref
                          .read(demoToggleProvider.notifier)
                          .setEnabled(value),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spaceL),
                platformUi.controls.textField(
                  label: 'Preview field',
                  placeholder: 'Interface input',
                  prefixIcon: const Icon(CupertinoIcons.search),
                ),
                const SizedBox(height: DesignTokens.spaceL),
                platformUi.controls.primaryButton(
                  onPressed: () => platformUi.overlays.notify(
                    context: context,
                    message: 'Interface ${platformUi.platform.name} active',
                  ),
                  child: const Text('Show platform feedback'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoSurface extends StatelessWidget {
  const _DemoSurface({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: DesignTokens.radiusMedium,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Padding(padding: DesignTokens.cardPadding, child: child),
    );
  }
}
