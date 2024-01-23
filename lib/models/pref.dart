import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import 'data/user_data.dart';

class Pref {
  Profile? profileData;

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

  Future<void> delete(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();

    String profileString = jsonEncode(profileData!.toJson());

    prefs.setString('profile_data', profileString);
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    String? profileString = prefs.getString('profile_data');

    if (profileString != null) {
      Map<String, dynamic> profileMap = jsonDecode(profileString);
      log(profileString);
      profileData = Profile.fromJson(profileMap);
    } else {
      profileData = Profile();
    }
  }
}
