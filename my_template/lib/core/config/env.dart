import 'package:envied/envied.dart';

part 'env.g.dart';

/// Doc https://pub.dev/packages/envied
@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'BUGFENDER_KEY', obfuscate: true)
  static String bugfenderKey = _Env.bugfenderKey;
}
