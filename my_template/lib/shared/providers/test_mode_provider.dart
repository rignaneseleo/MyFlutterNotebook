import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/logging/log.dart';

part 'test_mode_provider.g.dart';

@Riverpod(keepAlive: true)
bool isTestMode(IsTestModeRef ref) {
  try {
    return kDebugMode ;
  } catch (e) {
    Log.error("Error in isTestMode: $e");
    return false;
  }
}
