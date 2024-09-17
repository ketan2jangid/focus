import 'package:flutter/services.dart';

class NativeFunctionsController {
  static const _focusNativeBridge =
      MethodChannel("focus-native-kotlin-channel");

  NativeFunctionsController._();

  static final NativeFunctionsController instance =
      NativeFunctionsController._();

  Future<bool> hasOverlayPermission() async {
    return await _focusNativeBridge.invokeMethod("hasOverlayPermission");
  }

  Future<void> requestOverlayPermission() async {
    await _focusNativeBridge.invokeMethod("requestOverlayPermission");
  }

  Future<bool> hasUsageStatsPermission() async {
    return await _focusNativeBridge.invokeMethod("hasUsageStatsPermission");
  }

  Future<void> requestUsageStatsPermission() async {
    await _focusNativeBridge.invokeMethod("requestUsageStatsPermission");
  }

  Future<bool> hasAccessibilityPermission() async {
    return await _focusNativeBridge
        .invokeMethod("isAccessibilityServiceEnabled");
  }

  Future<void> requestAccessibilityPermission() async {
    await _focusNativeBridge.invokeMethod("requestAccessibilityPermission");
  }

  Future<void> startSchedule(Map<String, dynamic> schedule) async {
    await _focusNativeBridge.invokeMethod("startSchedule", schedule);
  }

  Future<void> endSchedule() async {
    await _focusNativeBridge.invokeMethod("endSchedule");
  }
}
