import 'package:flutter/widgets.dart';

import 'app_platform.dart';

class PlatformAction {
  const PlatformAction({
    required this.icon,
    required this.onPressed,
    this.label,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? label;
}

class PlatformMenuAction {
  const PlatformMenuAction({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isDestructive = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isDestructive;
}

class PlatformDestination {
  const PlatformDestination({
    required this.icon,
    required this.selectedIcon,
    required this.cupertinoIcon,
    required this.cupertinoSelectedIcon,
    required this.label,
    this.sfSymbol,
    this.selectedSfSymbol,
    this.key,
  });

  final IconData icon;
  final IconData selectedIcon;
  final IconData cupertinoIcon;
  final IconData cupertinoSelectedIcon;
  final String label;
  final String? sfSymbol;
  final String? selectedSfSymbol;
  final Key? key;
}

abstract interface class PlatformShell {
  Widget buildMainShell({
    Key? key,
    required Widget body,
    required List<PlatformDestination> destinations,
    required int selectedIndex,
    required ValueChanged<int> onSelected,
    Color? backgroundColor,
  });

  Widget buildPage({
    Key? key,
    required String title,
    required Widget body,
    List<PlatformAction> actions,
    Color? backgroundColor,
    bool resizeToAvoidBottomInset,
  });
}

abstract interface class PlatformControls {
  Widget switchToggle({
    Key? key,
    required bool value,
    required ValueChanged<bool>? onChanged,
  });

  Widget textField({
    Key? key,
    TextEditingController? controller,
    String? label,
    String? placeholder,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool obscureText,
    TextInputType? keyboardType,
    ValueChanged<String>? onSubmitted,
  });

  Widget primaryButton({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
  });

  Widget progressIndicator({Key? key, Color? color, double? size});
}

abstract interface class PlatformOverlays {
  Future<bool?> confirm({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmLabel,
    required String cancelLabel,
    bool isDestructive,
  });

  void notify({
    required BuildContext context,
    required String message,
    bool isError,
  });
}

abstract interface class PlatformMotion {
  Duration get pageTransitionDuration;

  Widget buildPageTransition({
    required BuildContext context,
    required Animation<double> animation,
    required Animation<double> secondaryAnimation,
    required Widget child,
  });
}

abstract interface class PlatformUi {
  AppPlatform get platform;

  PlatformShell get shell;
  PlatformControls get controls;
  PlatformOverlays get overlays;
  PlatformMotion get motion;
}
