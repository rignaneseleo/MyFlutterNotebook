import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_api.g.dart';

// TODO: This needs instantiation in runApp:
// https://riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis
@Riverpod(keepAlive: true)
SharedPreferencesApi sharedPreferencesApi(SharedPreferencesApiRef ref) =>
    throw UnimplementedError("This needs instantiation in runApp, "
        "see: https://riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis");

class SharedPreferencesApi {
  SharedPreferencesApi(this.sp);

  final SharedPreferences sp;

  Future<void> setString(String key, String value) async {
    await sp.setString(key, value);
  }

  String? getString(String key) {
    return sp.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    await sp.setBool(key, value);
  }

  bool? getBool(String key) {
    return sp.getBool(key);
  }

  Future<void> setInt(String key, int value) async {
    await sp.setInt(key, value);
  }

  int? getInt(String key) {
    return sp.getInt(key);
  }

  Future<void> setDouble(String key, double value) async {
    await sp.setDouble(key, value);
  }

  double? getDouble(String key) {
    return sp.getDouble(key);
  }

  Future<void> setStringList(String key, List<String> value) async {
    await sp.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return sp.getStringList(key);
  }

  Future<void> remove(String key) async {
    await sp.remove(key);
  }

  Future<void> clear() async {
    await sp.clear();
  }

  bool containsKey(String key) {
    return sp.containsKey(key);
  }
}
