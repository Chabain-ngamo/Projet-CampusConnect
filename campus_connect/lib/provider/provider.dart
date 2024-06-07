
 import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProvider extends ChangeNotifier{
  bool _isDark = false;
  bool _isEnglishSelected = true;
  Locale _currentLocale = Locale('en');

  bool get isDark => _isDark;
  bool get isEnglishSelected => _isEnglishSelected;
  Locale get currentLocale => _currentLocale;

  late SharedPreferences storage;

  //Custom dark theme
  final darkTheme = ThemeData(
    primaryColor: Colors.black12,
    brightness: Brightness.dark,
    primaryColorDark: Colors.black12,
  );

  //Custom light theme
  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    primaryColorDark: Colors.white
  );

  //Now we want to save the last changed theme value


  //Dark mode toggle action
  changeTheme(){
    _isDark = !isDark;

    //Save the value to secure storage
    storage.setBool("isDark", _isDark);
    notifyListeners();
  }

  changeLanguage(bool isEnglish) async {
    _isEnglishSelected = isEnglish;
    _currentLocale = isEnglish ? Locale('en') : Locale('fr');

    // Enregistre la langue sélectionnée dans les SharedPreferences
    await storage.setBool('isEnglishSelected', _isEnglishSelected);
    await storage.setString('currentLocale', _currentLocale.languageCode);

    notifyListeners();
  }

  Locale getLocale() {
    return _currentLocale;
  }


  //Init method of provider
  init()async{
    //After we re run the app
     storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool("isDark")??false;
    _isEnglishSelected = storage.getBool('isEnglishSelected') ?? true;
    _currentLocale = Locale(storage.getString('currentLocale') ?? 'en');

    notifyListeners();
  }
 }