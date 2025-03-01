import 'package:flutter/material.dart';

import '../../data/local/shared_preferences_service.dart';
import '../../utils/conversion.dart';

class SettingsProvider extends ChangeNotifier {
  final SharedPreferencesService _service;
  ThemeMode _themeMode = ThemeMode.system;
  String _username = "";
  String _message = "";

  String get message => _message;
  String get username => _username;
  ThemeMode get themeMode => _themeMode;

  SettingsProvider(this._service){
    getUsername();
    getTheme();
  }

  Future<void> setUsername(String newUsername) async {
    try {
      await _service.saveUsername(newUsername);
      _username = newUsername;
      _message = "Username saved!";
    } catch (e) {
      _message = "Failed to save your username";
    }
    notifyListeners();

    // _username = newUsername;
    // notifyListeners();
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('username', newUsername);
  }

  void getUsername() {
    try {
      _username = _service.getUsername();
      _message = "Username successfully retrieved";
    } catch (e) {
      _message = "Failed to get your username";
    }
    notifyListeners();
    // final prefs = await SharedPreferences.getInstance();
    // _username = prefs.getString('username') ?? "Guest";
    // notifyListeners();
  }

  void getTheme() {
    try {
      _themeMode = Conversion.intToTheme(_service.getTheme());
      _message = "Theme successfully retrieved";
    } catch (e) {
      _message = "Failed to get your Theme";
    }
    notifyListeners();
  }

  void setTheme(ThemeMode newThemeMode) async {
    try {
      await _service.saveTheme(Conversion.themeToInt(newThemeMode));
      _themeMode = newThemeMode;
      _message = "Theme saved!";
    } catch (e) {
      _message = "Failed to save your theme";
    }
    notifyListeners();
  }
}