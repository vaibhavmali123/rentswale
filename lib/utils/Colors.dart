import 'package:flutter/material.dart';

class color {
  static Color primaryColor = Colors.red;
  static Color successBtnColor = Colors.green;

  static Color colorConvert(String color) {
    color = color.replaceAll("#", "");
    if (color.length == 6) {
      return Color(int.parse("0xFF" + color));
    } else if (color.length == 8) {
      return Color(int.parse("0x" + color));
    }
  }
}
