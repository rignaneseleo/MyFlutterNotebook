import 'package:envied/envied.dart';

part 'env.g.dart';

/// Doc https://pub.dev/packages/envied
@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'KEY', obfuscate: true)
  static String bugFenderKey = _Env.bugFenderKey;
}
