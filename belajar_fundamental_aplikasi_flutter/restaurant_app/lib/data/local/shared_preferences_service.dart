import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  static const String keyTheme = "MYTHEME";
  static const String keyUsername = "MYUSERNAME";

  Future<void> saveTheme(int theme) async {
    try {
      await _preferences.setInt(keyTheme, theme);
    } catch (e) {
      throw Exception("Shared preferences cannot save the setting value.");
    }
  }

  int getTheme() {
    return _preferences.getInt(keyTheme) ?? 0;
  }

  Future<void> saveUsername(String username) async {
    try {
      await _preferences.setString(keyUsername, username);
    } catch (e) {
      throw Exception("Shared preferences cannot save the setting value.");
    }
  }

  String getUsername() {
    return _preferences.getString(keyUsername) ?? "Guest";
  }
}