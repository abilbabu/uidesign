import 'package:flutter/material.dart';

class AppStyle {
  static TextStyle getTextStyle(
      {required double fontSize, Color? color, bool isCurrency = false}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: isCurrency ? null : "Poppins",
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle getSubTextStyle(
      {required double fontSize, Color? color, bool isCurrency = false}) {
    return TextStyle(
      fontStyle: FontStyle.italic,
      fontSize: fontSize,
      fontFamily: isCurrency ? null : "Poppins",
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle getPriceTextStyle(
      {required double fontSize, Color? color, bool isCurrency = false}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: isCurrency ? null : "Poppins",
      fontWeight: FontWeight.w700,
      color: color,
    );
  }
}
