import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;
  static const usersKey = 'users';
  static const loggedInKey = 'logged_in_user';
  static const savedJobsKey = 'saved_jobs';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveUser(
    String name,
    String email,
    String password,
  ) async {
    final Map<String, dynamic> all = _getMap(_prefs.getString(usersKey));
    all[email] = {'name': name, 'password': password};
    return _prefs.setString(usersKey, json.encode(all));
  }

  static bool validateUser(String email, String password) {
    final Map<String, dynamic> all = _getMap(_prefs.getString(usersKey));
    if (!all.containsKey(email)) return false;
    final user = all[email];
    return (user is Map) && user['password'] == password;
  }

  static String? getUserName(String email) {
    final Map<String, dynamic> all = _getMap(_prefs.getString(usersKey));
    if (!all.containsKey(email)) return null;
    final user = all[email];
    return (user is Map) ? user['name'] : null;
  }

  static Future<void> setLoggedInUser(String email) async {
    await _prefs.setString(loggedInKey, email);
  }

  static String? getLoggedInUser() {
    return _prefs.getString(loggedInKey);
  }

  static Future<void> logout() async {
    await _prefs.remove(loggedInKey);
  }

  static List<String> getSavedJobsRaw() {
    return _prefs.getStringList(savedJobsKey) ?? [];
  }

  static Future<bool> saveJobsRaw(List<String> list) {
    return _prefs.setStringList(savedJobsKey, list);
  }

  static Map<String, dynamic> _getMap(String? s) {
    if (s == null || s.isEmpty) return {};
    try {
      final m = json.decode(s);
      return (m is Map) ? Map<String, dynamic>.from(m) : {};
    } catch (e) {
      return {};
    }
  }
}
