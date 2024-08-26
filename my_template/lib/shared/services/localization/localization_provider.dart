import 'package:flutter_translate/flutter_translate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'localization_provider.g.dart';

// TODO remember to init this in main
//  see https://riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis
@Riverpod(keepAlive: true)
LocalizationDelegate localizationDelegate(LocalizationDelegateRef ref) =>
    throw UnimplementedError();
