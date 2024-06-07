import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";

  /// saving data to sharedpreference
  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  /// fetching data from sharedpreference

  static Future<bool> getUserLoggedInSharedPreference() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool? isUserLoggedIn = preferences.getBool(sharedPreferenceUserLoggedInKey);
  if (isUserLoggedIn != null) {
    return isUserLoggedIn;
  } else {
    return false;
  }
}


  static Future<String> getUserNameSharedPreference() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? userName = preferences.getString(sharedPreferenceUserNameKey);
  if (userName != null) {
    return userName;
  } else {
    return '';
  }
}


  static Future<String> getUserEmailSharedPreference() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? userEmail = preferences.getString(sharedPreferenceUserEmailKey);
  if (userEmail != null) {
    return userEmail;
  } else {
    return '';
  }
}


}