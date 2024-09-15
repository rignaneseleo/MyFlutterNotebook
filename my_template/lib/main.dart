import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bugfender/flutter_bugfender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_template/shared/providers/device_info_provider.dart';
import 'package:my_template/shared/providers/package_info_provider.dart';
import 'package:my_template/shared/services/shared_preferences/shared_preferences_api.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

import 'app.dart';
import 'core/config/env.dart';
import 'core/config/firebase_options.dart';
import 'core/logging/log.dart';

void main() {
  FlutterBugfender.handleUncaughtErrors(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();

    // Initialize Bugfender, this should be done before any log
    await _setupBugFender();

    // Setting SystemUIOverlay
    _setupSystemUIOverlay();

    // Initialize Firebase, this should be done before any other Firebase service
    /*await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );*/

    final riverpodContainer = ProviderContainer(
      // see https://riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis
      overrides: [
        // Init SharedPreferences
        sharedPreferencesApiProvider.overrideWithValue(
          SharedPreferencesApi(await SharedPreferences.getInstance()),
        ),
        // Init PackageInfo
        packageInfoProvider.overrideWithValue(
          await PackageInfo.fromPlatform(),
        ),
        // Init DeviceInfo
        deviceInfoProvider.overrideWithValue(
          await switch (UniversalPlatform.value) {
            UniversalPlatformType.Web => DeviceInfoPlugin().webBrowserInfo,
            UniversalPlatformType.Android => DeviceInfoPlugin().androidInfo,
            UniversalPlatformType.IOS => DeviceInfoPlugin().iosInfo,
            UniversalPlatformType.MacOS => DeviceInfoPlugin().macOsInfo,
            UniversalPlatformType.Windows => DeviceInfoPlugin().windowsInfo,
            UniversalPlatformType.Linux => DeviceInfoPlugin().linuxInfo,
            _ => throw UnimplementedError(),
          },
        ),
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
        child: EasyLocalization(
          supportedLocales: const [
            Locale('en'),
            //Locale('it', 'IT'),
          ],
          path: 'assets/i18n',
          // <-- change the path of the translation files
          fallbackLocale: const Locale('en'),
          child: App(),
        ),
      ),
    );
  });
}

void _setupSystemUIOverlay() {
  //Setting SystemUIOverlay
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      //Status bar color
      statusBarColor: Colors.black.withOpacity(0.05),
      systemStatusBarContrastEnforced: true,
      //Navigation bar color
      systemNavigationBarColor: Colors.black.withOpacity(0.05),
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  //Setting SystmeUIMode
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );
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
