import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  String _username = "Guest";

  String get username => _username;

  Future<void> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username') ?? "Guest";
    notifyListeners();
  }

  Future<void> setUsername(String newUsername) async {
    _username = newUsername;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', newUsername);
  }
}