# Front Platform Theme Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add the lightweight UI foundation for `kid_app`: app root, theme configuration, platform abstraction, and a proof home screen.

**Architecture:** Keep the app front-first and layer-light. Theme lives in `lib/config/theme`, platform behavior in `lib/core/platform`, shared page wrappers in `lib/presentation/widgets/common`, and the current demo screen in `lib/presentation/pages/home`.

**Tech Stack:** Flutter 3, Dart 3.10, Flutter Riverpod, Material, Cupertino, flutter_test.

---

### Task 1: Failing Contract Tests

**Files:**
- Modify: `pubspec.yaml`
- Modify: `test/widget_test.dart`
- Create: `test/core/platform/platform_ui_provider_test.dart`
- Create: `test/config/theme/app_theme_test.dart`

- [x] Add Riverpod dependency to `pubspec.yaml`.
- [x] Replace the template widget test with app/platform expectations.
- [x] Add provider and theme contract tests.
- [x] Run `flutter test`; expected result is failure because implementation files do not exist yet.

### Task 2: Theme Foundation

**Files:**
- Create: `lib/config/theme/app_colors.dart`
- Create: `lib/config/theme/design_tokens.dart`
- Create: `lib/config/theme/widgets/text_theme.dart`
- Create: `lib/config/theme/theme.dart`
- Create: `lib/config/theme/cupertino_theme.dart`

- [x] Add color tokens for light and dark modes.
- [x] Add spacing, radius, height, and motion tokens.
- [x] Add shared text styles with system fallbacks.
- [x] Add Material and Cupertino theme data.
- [x] Run theme tests.

### Task 3: Platform Foundation

**Files:**
- Create: `lib/core/platform/app_platform.dart`
- Create: `lib/core/platform/platform_ui.dart`
- Create: `lib/core/platform/platform_ui_provider.dart`
- Create: `lib/core/platform/impl/material_platform_ui.dart`
- Create: `lib/core/platform/impl/cupertino_platform_ui.dart`

- [x] Add `AppPlatform` resolution from `defaultTargetPlatform`.
- [x] Add platform-neutral contracts.
- [x] Add Riverpod providers.
- [x] Add Material and Cupertino implementations.
- [x] Run platform tests.

### Task 4: App Root and Demo Page

**Files:**
- Modify: `lib/main.dart`
- Create: `lib/app.dart`
- Create: `lib/presentation/widgets/common/platform_page.dart`
- Create: `lib/presentation/pages/home/home_screen.dart`

- [x] Wrap the app in `ProviderScope`.
- [x] Create `KidApp` with Material or Cupertino host based on `platformUiProvider`.
- [x] Add `PlatformPage`.
- [x] Add a simple home screen using platform controls.
- [x] Run `flutter analyze` and `flutter test`.

