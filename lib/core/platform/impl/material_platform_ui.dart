import 'package:flutter/material.dart';

import '../../../config/theme/design_tokens.dart';
import '../app_platform.dart';
import '../platform_ui.dart';

class MaterialPlatformUi implements PlatformUi {
  const MaterialPlatformUi([this._platform = AppPlatform.android]);

  final AppPlatform _platform;

  @override
  AppPlatform get platform => _platform;

  @override
  PlatformShell get shell => const MaterialShell();

  @override
  PlatformControls get controls => const MaterialControls();

  @override
  PlatformOverlays get overlays => const MaterialOverlays();

  @override
  PlatformMotion get motion => const MaterialMotion();
}

class MaterialShell implements PlatformShell {
  const MaterialShell();

  @override
  Widget buildPage({
    Key? key,
    required String title,
    required Widget body,
    List<PlatformAction> actions = const [],
    Color? backgroundColor,
    bool resizeToAvoidBottomInset = true,
  }) {
    return Scaffold(
      key: key,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: AppBar(
        title: Text(title),
        actions: [
          for (final action in actions)
            IconButton(
              icon: Icon(action.icon),
              tooltip: action.label,
              onPressed: action.onPressed,
            ),
        ],
      ),
      body: body,
    );
  }
}

class MaterialControls implements PlatformControls {
  const MaterialControls();

  @override
  Widget switchToggle({
    Key? key,
    required bool value,
    required ValueChanged<bool>? onChanged,
  }) {
    return Switch(key: key, value: value, onChanged: onChanged);
  }

  @override
  Widget textField({
    Key? key,
    TextEditingController? controller,
    String? label,
    String? placeholder,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool obscureText = false,
    TextInputType? keyboardType,
    ValueChanged<String>? onSubmitted,
  }) {
    return TextField(
      key: key,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: label,
        hintText: placeholder,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }

  @override
  Widget primaryButton({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
  }) {
    return ElevatedButton(key: key, onPressed: onPressed, child: child);
  }

  @override
  Widget progressIndicator({Key? key, Color? color, double? size}) {
    final indicator = CircularProgressIndicator(
      key: key,
      strokeWidth: 2,
      color: color,
    );
    if (size == null) return indicator;
    return SizedBox.square(dimension: size, child: indicator);
  }
}

class MaterialOverlays implements PlatformOverlays {
  const MaterialOverlays();

  @override
  Future<bool?> confirm({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmLabel,
    required String cancelLabel,
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(cancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: isDestructive
                ? TextButton.styleFrom(
                    foregroundColor: Theme.of(dialogContext).colorScheme.error,
                  )
                : null,
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
  }

  @override
  void notify({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: isError ? Theme.of(context).colorScheme.error : null,
          margin: DesignTokens.pagePadding,
        ),
      );
  }
}

class MaterialMotion implements PlatformMotion {
  const MaterialMotion();

  @override
  Duration get pageTransitionDuration => DesignTokens.motionSlow;

  @override
  Widget buildPageTransition({
    required BuildContext context,
    required Animation<double> animation,
    required Animation<double> secondaryAnimation,
    required Widget child,
  }) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: DesignTokens.curveEmphasized,
      reverseCurve: Curves.easeInCubic,
    );

    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.05),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }
}
