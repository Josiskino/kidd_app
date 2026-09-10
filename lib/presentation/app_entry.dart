import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers/onboarding/app_entry_provider.dart';
import 'main/main_shell.dart';
import 'starter/starter_screen.dart';

class AppEntry extends ConsumerWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasStarted = ref.watch(appEntryProvider);

    return hasStarted ? const MainShell() : const StarterScreen();
  }
}
