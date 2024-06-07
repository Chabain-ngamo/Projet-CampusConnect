import 'package:flutter/material.dart';
import 'package:campus_connect/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('en');

  LanguageProvider() {
    // Initialiser l'état avec les préférences utilisateur, si elles existent
    _loadLocale();
  }

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    _saveLocale(locale);
    notifyListeners();
  }

  void _loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');
    if (languageCode != null) {
      _locale = Locale(languageCode);
      notifyListeners();
    }
  }

  void _saveLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', locale.languageCode);
  }
}

