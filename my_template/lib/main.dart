import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bugfender/flutter_bugfender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_template/shared/providers/package_info_provider.dart';
import 'package:my_template/shared/services/shared_preferences/shared_preferences_api.dart';
import 'package:universal_platform/universal_platform.dart';

import 'app.dart';
import 'core/config/env.dart';
import 'core/logging/log.dart';

void main() {
  FlutterBugfender.handleUncaughtErrors(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Bugfender, this should be done before any log
    await _setupBugFender();

    final riverpodContainer = ProviderContainer(
      overrides: [
        // see https://riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis
        sharedPreferencesApiProvider.overrideWithValue(
            SharedPreferencesApi(await SharedPreferences.getInstance())),
        packageInfoProvider.overrideWithValue(await PackageInfo.fromPlatform()),
      ],
      observers: [Logger()],
    );

    // Initialize Firebase, this should be done before any other Firebase service
    //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    // Firebase emulator,
    //if (kDebugMode && kUseTestFirebase) await _setupEmulator(riverpodContainer);

    runApp(
      UncontrolledProviderScope(
        container: riverpodContainer,
        child: App(),
      ),
    );
  });
}

Future<void> _setupBugFender() async {
  if (UniversalPlatform.isMacOS) return;

  await FlutterBugfender.init(
    Env.bugfenderKey,
    enableCrashReporting: true, // these are optional, but recommended
    enableUIEventLogging: !kIsWeb, //on web it's not supported
    enableAndroidLogcatLogging: true,
    printToConsole: true,
  );

  Log.generic(">>>>> RUNNING WITH BUGFENDER <<<<<<<<");
}
