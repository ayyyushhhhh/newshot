import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData lightThemeData =
      ThemeData.light().copyWith(primaryColor: Colors.white);
  ThemeData nightThemeData = ThemeData.dark();
  ThemeData appThemeData =
      ThemeData.light().copyWith(primaryColor: Colors.white);
  bool isDark = false;
  void changeTheme(bool value) {
    if (value == true) {
      appThemeData = nightThemeData;
      isDark = true;
    } else if (value == false) {
      appThemeData = lightThemeData;
      isDark = false;
    }
    notifyListeners();
  }
}
