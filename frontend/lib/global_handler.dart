import 'package:shared_preferences/shared_preferences.dart';

class GlobalHandler {
  static const String USER_ID_KEY = "user_id";
  static const String USERNAME_KEY = "username";
  static const String EMAIL_KEY = "email";
  static const String TOKEN_KEY = "token";
  static const String CREATED_AT_KEY = "created_at";

  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(USER_ID_KEY, userData['_id']);
    await prefs.setString(USERNAME_KEY, userData['username']);
    await prefs.setString(EMAIL_KEY, userData['email']);
    await prefs.setString(TOKEN_KEY, userData['token']);
    await prefs.setString(CREATED_AT_KEY, userData['createdAt']);
  }

  static Future<Map<String, dynamic>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      "_id": prefs.getString(USER_ID_KEY) ?? "",
      "username": prefs.getString(USERNAME_KEY) ?? "",
      "email": prefs.getString(EMAIL_KEY) ?? "",
      "token": prefs.getString(TOKEN_KEY) ?? "",
      "createdAt": prefs.getString(CREATED_AT_KEY) ?? "",
    };
  }

  static Future<bool> hasAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('token');
    return authToken != null;
  }
}
