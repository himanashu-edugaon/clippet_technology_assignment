

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static Future<void> saveUserSession(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
  }

  static Future<String?> getUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }

  static Future<void> clearUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userName');
  }
}
