import 'package:campus_connect/services/dark_theme_prefs.dart';
import 'package:flutter/cupertino.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePrefs darkThemePrefs = DarkThemePrefs();
  bool _darkTheme = false;

  DarkThemeProvider() {
    _loadThemeFromPrefs();
  }

  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemePrefs.setDarkTheme(value);
    notifyListeners();
  }

  Future<void> _loadThemeFromPrefs() async {
    _darkTheme = await darkThemePrefs.getTheme();
    notifyListeners();
  }
}
