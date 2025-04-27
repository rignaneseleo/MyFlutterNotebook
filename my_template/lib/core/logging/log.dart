import 'package:flutter/foundation.dart';
import 'package:flutter_bugfender/flutter_bugfender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_platform/universal_platform.dart';

class Log {
  static void setup({
    required String? type,
    required String? email,
    required String? uid,
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

  static void info(dynamic author, String message) {
    if (UniversalPlatform.isMacOS) return;

    FlutterBugfender.info("[${author.runtimeType}] $message");
  }

  static void generic(dynamic author, String message) {
    if (UniversalPlatform.isMacOS) return;

    FlutterBugfender.log("[${author.runtimeType}] $message");
  }

  static void error(dynamic author, String message, {Object? error}) {
    if (UniversalPlatform.isMacOS) return;

    FlutterBugfender.error(
      "[${author.runtimeType}] $message${error != null ? ": $error" : ""}",
    );
    //if (kDebugMode) throw Exception(message);
  }

  static void trace(dynamic author, String message) {
    if (UniversalPlatform.isMacOS) return;

    FlutterBugfender.trace("[${author.runtimeType}] $message");
    //if (kDebugMode) throw Exception(message);
  }

  static void warn(dynamic author, String message) {
    if (UniversalPlatform.isMacOS) return;

    FlutterBugfender.warn("[${author.runtimeType}] $message");
  }

  static void debug(dynamic author, String message) {
    if (UniversalPlatform.isMacOS) return;

    FlutterBugfender.debug("[${author.runtimeType}] $message");
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
        this,
        '''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "previousValue": "$previousValue",
  "newValue": "$newValue"
}
      ''',
      );
    }
  }
}
