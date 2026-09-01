# Front Platform Theme Design

## Goal

Build a lightweight front-end foundation for `kid_app`, based on the proven UI
patterns in `supplies_chat_app`, without introducing `data`, `domain`, API,
flavors, Firebase, realtime, or desktop-specific workspace behavior.

## Scope

The first layer contains only:

- application root configuration;
- Material and Cupertino themes;
- design tokens and color tokens;
- platform resolution through Flutter's `defaultTargetPlatform`;
- a `PlatformUi` abstraction for pages, controls, overlays, and motion;
- a shared `PlatformPage` wrapper;
- one simple home screen proving the structure works.

## Architecture

`lib/main.dart` stays small and delegates to `KidApp` in `lib/app.dart`.
`KidApp` is a `ConsumerWidget` wrapped by `ProviderScope`. It reads the current
platform from Riverpod and chooses a Material or Cupertino host while sharing the
same page tree.

Screens must not call `Platform.isIOS` or `Platform.isAndroid`. Platform-specific
rendering is centralized in `core/platform/impl/`, and screens consume it through
`PlatformPage` and `platformUiProvider`.

## Platform Behavior

Android uses Material widgets: `Scaffold`, `AppBar`, `Switch`, `TextField`,
`ElevatedButton`, `SnackBar`, and Material-style transitions.

iOS uses Cupertino vocabulary where it matters: `CupertinoPageScaffold`,
`CupertinoNavigationBar`, `CupertinoSwitch`, `CupertinoTextField`,
`CupertinoButton`, `CupertinoAlertDialog`, action sheets, and
`CupertinoPageTransition`.

`AppPlatform.current` is based on `defaultTargetPlatform`, not `dart:io`, so tests
can override the platform from one machine.

## Theming

The palette is child-oriented and intentionally separate from 01Supplies branding:
soft blue as primary, warm yellow as accent, green as success, with light and dark
surface tokens. Typography uses system-font fallbacks first, so it is stable
without downloading fonts.

Material and Cupertino themes are defined separately but share the same color and
type tokens.

## Testing

Widget tests cover:

- `KidApp` renders the home page;
- Android override renders a Material page shell;
- iOS override renders a Cupertino page shell;
- platform provider can be overridden in tests;
- theme colors keep text readable in light and dark modes.
