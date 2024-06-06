import 'package:flutter/material.dart';
import 'app_themedata.dart';  // Import the theme file

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = darkTheme;

  ThemeData get currentTheme => _currentTheme;

  void switchTheme() {
    if (_currentTheme == lightTheme) {
      _currentTheme = darkTheme;
    } else {
      _currentTheme = lightTheme;
    }
    notifyListeners();
  }
}
