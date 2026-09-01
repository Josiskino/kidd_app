import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Material, MaterialType;

import '../app_platform.dart';
import '../platform_ui.dart';

class CupertinoPlatformUi implements PlatformUi {
  const CupertinoPlatformUi();

  @override
  AppPlatform get platform => AppPlatform.ios;

  @override
  PlatformShell get shell => const CupertinoShell();

  @override
  PlatformControls get controls => const CupertinoControls();

  @override
  PlatformOverlays get overlays => const CupertinoOverlays();

  @override
  PlatformMotion get motion => const CupertinoMotion();
}

class CupertinoShell implements PlatformShell {
  const CupertinoShell();

  @override
  Widget buildMainShell({
    Key? key,
    required Widget body,
    required List<PlatformDestination> destinations,
    required int selectedIndex,
    required ValueChanged<int> onSelected,
    Color? backgroundColor,
  }) {
    return AdaptiveScaffold(
      key: key,
      enableToolbarGradient: false,
      enableBlur: false,
      body: _withBackground(_withMaterial(body), backgroundColor),
      bottomNavigationBar: AdaptiveBottomNavigationBar(
        useNativeBottomBar: true,
        selectedIndex: selectedIndex,
        onTap: onSelected,
        items: [
          for (final destination in destinations)
            AdaptiveNavigationDestination(
              icon: destination.sfSymbol ?? destination.cupertinoIcon,
              selectedIcon:
                  destination.selectedSfSymbol ??
                  destination.cupertinoSelectedIcon,
              label: destination.label,
            ),
        ],
      ),
    );
  }

  @override
  Widget buildPage({
    Key? key,
    required String title,
    required Widget body,
    List<PlatformAction> actions = const [],
    Color? backgroundColor,
    bool resizeToAvoidBottomInset = true,
  }) {
    return AdaptiveScaffold(
      key: key,
      enableToolbarGradient: false,
      enableBlur: false,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: AdaptiveAppBar(
        title: title,
        useNativeToolbar: true,
        actions: actions.isEmpty
            ? null
            : [
                for (final action in actions)
                  AdaptiveAppBarAction(
                    icon: action.icon,
                    onPressed: action.onPressed,
                  ),
              ],
      ),
      body: SafeArea(
        top: false,
        child: _withBackground(_withMaterial(body), backgroundColor),
      ),
    );
  }

  static Widget _withMaterial(Widget child) {
    return Material(type: MaterialType.transparency, child: child);
  }

  static Widget _withBackground(Widget child, Color? color) {
    if (color == null) return child;
    return ColoredBox(color: color, child: child);
  }
}

class CupertinoControls implements PlatformControls {
  const CupertinoControls();

  @override
  Widget switchToggle({
    Key? key,
    required bool value,
    required ValueChanged<bool>? onChanged,
  }) {
    return AdaptiveSwitch(key: key, value: value, onChanged: onChanged);
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
    return AdaptiveTextField(
      key: key,
      controller: controller,
      placeholder: placeholder ?? label,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
    );
  }

  @override
  Widget primaryButton({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
  }) {
    return AdaptiveButton.child(key: key, onPressed: onPressed, child: child);
  }

  @override
  Widget progressIndicator({Key? key, Color? color, double? size}) {
    final indicator = CupertinoActivityIndicator(key: key, color: color);
    if (size == null) return indicator;
    return SizedBox.square(dimension: size, child: indicator);
  }
}

class CupertinoOverlays implements PlatformOverlays {
  const CupertinoOverlays();

  @override
  Future<bool?> confirm({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmLabel,
    required String cancelLabel,
    bool isDestructive = false,
  }) {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(cancelLabel),
          ),
          CupertinoDialogAction(
            isDestructiveAction: isDestructive,
            onPressed: () => Navigator.of(dialogContext).pop(true),
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
    AdaptiveSnackBar.show(
      context,
      message: message,
      type: isError ? AdaptiveSnackBarType.error : AdaptiveSnackBarType.info,
    );
  }
}

class CupertinoMotion implements PlatformMotion {
  const CupertinoMotion();

  @override
  Duration get pageTransitionDuration => const Duration(milliseconds: 400);

  @override
  Widget buildPageTransition({
    required BuildContext context,
    required Animation<double> animation,
    required Animation<double> secondaryAnimation,
    required Widget child,
  }) {
    return CupertinoPageTransition(
      primaryRouteAnimation: animation,
      secondaryRouteAnimation: secondaryAnimation,
      linearTransition: false,
      child: child,
    );
  }
}
