import 'package:flutter/material.dart';

class Conversion {
  static int themeToInt(ThemeMode theme){
    if (theme == ThemeMode.system) {
      return 0;
    } else if (theme == ThemeMode.dark){
      return 1;
    } else {
      return 2;
    }
  }

  static ThemeMode intToTheme(int theme){
    if (theme == 0) {
      return ThemeMode.system;
    } else if (theme == 1){
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }
}


