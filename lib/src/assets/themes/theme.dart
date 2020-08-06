import 'package:flutter/material.dart';

const Color APP_PRIMARY_COLOR = Colors.green;
const Color APP_THEME_COLOR = Color(0xFFEEEEEE);
const Color WHITE_COLOR = Colors.white;
const Color APP_TEXT_COLOR = Colors.black;

ThemeData lightTheme() {
  return ThemeData(
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey[200],
    primaryTextTheme: TextTheme(
      headline6: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: APP_PRIMARY_COLOR,
      ),
      headline5: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: APP_PRIMARY_COLOR,
      ),
      headline4: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: APP_PRIMARY_COLOR,
      ),
      headline3: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: APP_PRIMARY_COLOR,
      ),
      headline2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: APP_PRIMARY_COLOR,
      ),
      headline1: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: APP_PRIMARY_COLOR,
      ),
      subtitle1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: APP_PRIMARY_COLOR,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: APP_PRIMARY_COLOR,
      ),
      bodyText1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: APP_PRIMARY_COLOR,
      ),
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: APP_TEXT_COLOR,
      ),
      headline5: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: APP_TEXT_COLOR,
      ),
      headline4: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: APP_TEXT_COLOR,
      ),
      headline3: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: APP_TEXT_COLOR,
      ),
      headline2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: APP_TEXT_COLOR,
      ),
      headline1: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: APP_TEXT_COLOR,
      ),
      subtitle1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: APP_TEXT_COLOR,
      ),
      bodyText2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: APP_TEXT_COLOR,
      ),
      bodyText1: TextStyle(
        letterSpacing: 0,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.grey[700],
      ),
    ),
    accentTextTheme: TextTheme(headline6: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: WHITE_COLOR,
      ),
      headline5: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: APP_TEXT_COLOR,
      ),headline4: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color:  Colors.grey,
      ),
      headline3: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.grey[600],
      ),bodyText2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.grey[700],
      ),
      ),
    appBarTheme: const AppBarTheme(
      color: Colors.grey,
      elevation: 0.0,
    ),
    iconTheme: const IconThemeData(
      color: WHITE_COLOR,
    ),
    );
}
