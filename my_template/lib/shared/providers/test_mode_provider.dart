import 'package:flutter/foundation.dart';
import 'package:my_template/core/logging/log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'test_mode_provider.g.dart';

@Riverpod(keepAlive: true)
bool isTestMode(IsTestModeRef ref) {
  try {
    return kDebugMode;
  } catch (e) {
    Log.error(isTestModeProvider, "Error in isTestMode: $e");
    return false;
  }
}
