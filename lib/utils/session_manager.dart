import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void setBool(String key, bool value) {
    _prefs.setBool(key, value);
  }

  static bool getBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  static void clearSession() {
    _prefs.remove('isLoggedIn');
    _prefs.remove('isOtpVerified');
  }
}
