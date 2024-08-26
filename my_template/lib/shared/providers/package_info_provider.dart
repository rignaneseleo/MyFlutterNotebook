import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'package_info_provider.g.dart';

// TODO remember to init this in main
//  see https://riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis
@Riverpod(keepAlive: true)
PackageInfo packageInfo(PackageInfoRef ref) => throw UnimplementedError();
