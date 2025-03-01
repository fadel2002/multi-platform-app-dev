import 'package:flutter/material.dart';

import '../../data/local/shared_preferences_service.dart';
import '../../utils/conversion.dart';

class SettingsProvider extends ChangeNotifier {
  final SharedPreferencesService _service;
  ThemeMode _themeMode = ThemeMode.system;
  String _username = "";
  String _message = "";
  bool _isReminderEnabled = false;

  String get message => _message;
  String get username => _username;
  ThemeMode get themeMode => _themeMode;
  bool get isReminderEnabled => _isReminderEnabled;

  SettingsProvider(this._service){
    getUsername();
    getTheme();
    getReminderSetting();
  }

  Future<void> setUsername(String newUsername) async {
    try {
      await _service.saveUsername(newUsername);
      _username = newUsername;
      _message = "Username saved!";
    } catch (e) {
      _message = "Failed to save username";
    }
    notifyListeners();
  }

  void getUsername() {
    try {
      _username = _service.getUsername();
      _message = "Username successfully retrieved";
    } catch (e) {
      _message = "Failed to get username";
    }
    notifyListeners();
  }

  void getTheme() {
    try {
      _themeMode = Conversion.intToTheme(_service.getTheme());
      _message = "Theme successfully retrieved";
    } catch (e) {
      _message = "Failed to get theme setting";
    }
    notifyListeners();
  }

  void setTheme(ThemeMode newThemeMode) async {
    try {
      await _service.saveTheme(Conversion.themeToInt(newThemeMode));
      _themeMode = newThemeMode;
      _message = "Theme saved!";
    } catch (e) {
      _message = "Failed to save theme setting";
    }
    notifyListeners();
  }

  void getReminderSetting() {
    try {
      _isReminderEnabled = _service.getReminder();
    } catch (e) {
      _message = "Failed to get reminder setting";
      _isReminderEnabled = false;
    }
    notifyListeners();
  }

  Future<void> setReminder(bool value) async {
    try {
      await _service.saveReminder(value);
      _isReminderEnabled = value;
    } catch (e) {
      _message = "Failed to save reminder setting";
    }
    notifyListeners();
  }
}