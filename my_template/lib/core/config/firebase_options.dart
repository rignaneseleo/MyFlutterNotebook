// TODO Install FlutterFire CLI and run the following command:
// $ flutterfire config  --out=lib/core/config/firebase_options.dart
// Then, in your main.dart file, import the generated file:
// import 'firebase_options.dart';
// And initialize Firebase with the generated options:
// await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// This will configure Firebase for your app on all platforms.

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => throw UnimplementedError();
}
