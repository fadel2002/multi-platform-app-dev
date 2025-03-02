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

  static String timeFormat(int hour, int minute){
    String time = "";
    if (hour < 10) {
      time += "0$hour";
    } else {
      time += "$hour";
    }
    if (minute < 10){
      time += ":0$minute";
    }else {
      time += "$minute";
    }
    if (hour < 9){
      time += " pagi";
    }else if (hour < 15){
      time += " siang";
    }else if (hour < 19){
      time += " sore";
    }else {
      time += " malam";
    }
    return time;
  }
}


