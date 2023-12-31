import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  Future<void> fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _locale = const Locale('en');
    }else{
      _locale = Locale(prefs.getString('language_code') ?? 'en');
    }

  }

  Future<void> setLocale(Locale locale) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
    _locale = locale;
    notifyListeners();
  }
}
