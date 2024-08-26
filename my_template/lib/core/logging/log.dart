import 'package:flutter/foundation.dart';
import 'package:flutter_bugfender/flutter_bugfender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_platform/universal_platform.dart';

class Log {
  static void setup({
    required String? type,
    required String email,
    required String uid,
  }) {
    if (UniversalPlatform.isMacOS) return;
    FlutterBugfender.setDeviceString("user.type", type ?? "unknown");
    FlutterBugfender.setDeviceString("user.email", email ?? "null");
    FlutterBugfender.setDeviceString("user.id", uid ?? "null");
  }

  static void reset() {
    if (UniversalPlatform.isMacOS) return;

    FlutterBugfender.removeDeviceKey("user.type");
    FlutterBugfender.removeDeviceKey("user.email");
    FlutterBugfender.removeDeviceKey("user.id");
  }

  static void info(String message) {
    if (UniversalPlatform.isMacOS) return;

    FlutterBugfender.info("$message");
  }

  static void generic(String message) {
    if (UniversalPlatform.isMacOS) return;

    FlutterBugfender.log("$message");
  }

  static void error(String message) {
    if (UniversalPlatform.isMacOS) return;

    FlutterBugfender.error("$message");
    //if (kDebugMode) throw Exception(message);
  }

  static void trace(String message) {
    if (UniversalPlatform.isMacOS) return;

    FlutterBugfender.trace(message);
    //if (kDebugMode) throw Exception(message);
  }

  static void warn(String message) {
    if (UniversalPlatform.isMacOS) return;

    FlutterBugfender.warn("$message");
  }
}

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (kDebugMode) {
      Log.trace(
        '''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "previousValue": "$previousValue",
  "newValue": "$newValue"
}''',
      );
    }
  }
}
