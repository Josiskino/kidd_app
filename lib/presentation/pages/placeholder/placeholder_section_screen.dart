import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../../config/theme/design_tokens.dart';
import '../../widgets/common/platform_page.dart';

class PlaceholderSectionScreen extends StatelessWidget {
  const PlaceholderSectionScreen({
    super.key,
    required this.title,
    required this.headline,
    required this.body,
  });

  final String title;
  final String headline;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return PlatformPage(
      title: title,
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: ListView(
        padding: DesignTokens.pagePadding,
        children: [
          Text(headline, style: theme.textTheme.headlineMedium),
          const SizedBox(height: DesignTokens.spaceS),
          Text(body, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
