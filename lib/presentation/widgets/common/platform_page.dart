import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/platform/platform_ui.dart';
import '../../../core/platform/platform_ui_provider.dart';

class PlatformPage extends ConsumerWidget {
  const PlatformPage({
    super.key,
    required this.title,
    required this.body,
    this.actions = const [],
    this.backgroundColor,
  });

  final String title;
  final Widget body;
  final List<PlatformAction> actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platformUi = ref.watch(platformUiProvider);

    return platformUi.shell.buildPage(
      title: title,
      body: body,
      actions: actions,
      backgroundColor: backgroundColor,
    );
  }
}
