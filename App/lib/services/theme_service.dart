import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  bool _isDarkMode = false;
  SharedPreferences? _prefs;

  bool get isDarkMode => _isDarkMode;

  Future<void> initialize(bool initialTheme) async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode = initialTheme;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _prefs?.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}