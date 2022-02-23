import 'package:flutter/material.dart';

class Styles {
  static const CARD_BORDER_RADIUS = 6.0;
  static Color primaryColor = Colors.green[400];
  static Color accentColor = Colors.black54;
  static String fontFace = 'ProductSans';
  static ThemeData themeData = ThemeData(
      fontFamily: 'ProductSans',
      primaryColor: primaryColor,
      accentColor: accentColor,
      textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 24.0,
            color: accentColor,
          ),
          headline2: TextStyle(fontSize: 36.0, color: accentColor)));

  static TextStyle headerTextStyle = TextStyle(
    color: accentColor,
    fontWeight: FontWeight.normal,
    fontSize: 60,
  );

  static TextStyle paragraphTextStyle = TextStyle(
    color: accentColor,
    fontWeight: FontWeight.normal,
    fontSize: 20,
  );

  static RoundedRectangleBorder roundedBorderShape() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CARD_BORDER_RADIUS));
  }
}
