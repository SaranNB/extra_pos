import 'package:flutter/material.dart';

class AppColors {
  static final primaryColor = 0xFF3fbefe;
  static final primaryDarkColor = 0xFF3fbefe;

  static final Color statusBarColor = new Color(primaryColor);
  static final Color appBarColor = Colors.white;
  static final bool isStatusBarForegroundWhite = true;

  static final MaterialColor primaryMaterialColor = _factoryColor(primaryColor);
  static final MaterialColor primaryDarkMaterialColor =
      _factoryColor(primaryDarkColor);

  static final Color secondaryMenuIconColor = Color(0xff0052A2);

  // Utils
  static MaterialColor hex(String hex) =>
      AppColors._factoryColor(AppColors._getColorHexFromStr(hex));

  static MaterialColor _factoryColor(int color) {
    return MaterialColor(color, <int, Color>{
      50: Color(color),
      100: Color(color),
      200: Color(color),
      300: Color(color),
      400: Color(color),
      500: Color(color),
      600: Color(color),
      700: Color(color),
      800: Color(color),
      900: Color(color),
    });
  }

  static int _getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        val = 0xFFFFFFFF;
      }
    }
    return val;
  }
}
