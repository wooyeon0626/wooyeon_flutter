import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  Pref._privateConstructor();

  static final Pref _instance = Pref._privateConstructor();

  static Pref get instance => _instance;

  Future<void> save(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String?> get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
