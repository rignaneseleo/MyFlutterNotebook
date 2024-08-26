import 'dart:ui';

import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

///NOTE: this is used also in the kotlin and swift code
const String kSelectedLocaleKey = 'selected_locale';

class TranslatePreferences implements ITranslatePreferences {
  @override
  Future<Locale?> getPreferredLocale() async {
    final preferences = await SharedPreferences.getInstance();

    if (!preferences.containsKey(kSelectedLocaleKey)) return null;

    var locale = preferences.getString(kSelectedLocaleKey);

    print("Using custom locale: $locale");
    return localeFromString(locale ?? "en");
  }

  @override
  Future savePreferredLocale(Locale locale) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(kSelectedLocaleKey, localeToString(locale));
  }
}
