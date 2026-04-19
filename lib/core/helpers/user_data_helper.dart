import 'package:shared_preferences/shared_preferences.dart';

class UserDataHelper {
  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? 'User';
  }

  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') ?? 'user@example.com';
  }
  static Future<String> getPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('phone') ?? '';
  }
  static Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString('username') ?? 'User',
      'email': prefs.getString('email') ?? 'user@example.com',
      'phone': prefs.getString('phone') ?? '',
    };
  }
}
