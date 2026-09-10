import 'package:flutter_riverpod/flutter_riverpod.dart';

final appEntryProvider = NotifierProvider<AppEntryNotifier, bool>(
  AppEntryNotifier.new,
);

class AppEntryNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void completeStarter() => state = true;
}
