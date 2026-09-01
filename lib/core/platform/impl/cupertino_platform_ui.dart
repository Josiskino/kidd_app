import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Material, MaterialType;

import '../../../config/theme/design_tokens.dart';
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
  Widget buildPage({
    Key? key,
    required String title,
    required Widget body,
    List<PlatformAction> actions = const [],
    Color? backgroundColor,
    bool resizeToAvoidBottomInset = true,
  }) {
    return CupertinoPageScaffold(
      key: key,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
        trailing: actions.isEmpty
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final action in actions)
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: action.onPressed,
                      child: Icon(action.icon, semanticLabel: action.label),
                    ),
                ],
              ),
      ),
      child: SafeArea(
        top: false,
        child: Material(type: MaterialType.transparency, child: body),
      ),
    );
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
    return CupertinoSwitch(key: key, value: value, onChanged: onChanged);
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
    return CupertinoTextField(
      key: key,
      controller: controller,
      placeholder: placeholder ?? label,
      prefix: prefixIcon == null
          ? null
          : Padding(
              padding: const EdgeInsetsDirectional.only(start: 12),
              child: prefixIcon,
            ),
      suffix: suffixIcon == null
          ? null
          : Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: suffixIcon,
            ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: CupertinoDynamicColor.resolve(
          CupertinoColors.secondarySystemGroupedBackground,
          key == null
              ? WidgetsBinding.instance.rootElement!
              : key as BuildContext,
        ),
        borderRadius: BorderRadius.circular(DesignTokens.radiusM),
      ),
    );
  }

  @override
  Widget primaryButton({
    Key? key,
    required Widget child,
    required VoidCallback? onPressed,
  }) {
    return CupertinoButton.filled(
      key: key,
      onPressed: onPressed,
      borderRadius: BorderRadius.circular(DesignTokens.radiusM),
      child: child,
    );
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
    showCupertinoModalPopup<void>(
      context: context,
      builder: (sheetContext) => CupertinoActionSheet(
        title: Text(message),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(sheetContext).pop(),
          child: const Text('OK'),
        ),
      ),
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
