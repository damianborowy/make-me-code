import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback onResume;
  final AsyncCallback onPause;

  LifecycleEventHandler({
    required this.onResume,
    required this.onPause,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await onResume();
        print("resumed");
        break;
      case AppLifecycleState.paused:
        await onPause();
        print("paused");
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
    }
  }
}
