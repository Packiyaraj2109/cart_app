

import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryTextTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold),
      headline3: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold),
      headline4: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold),
      headline3: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold),
      headline4: TextStyle(
        color:Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        fontSize: 16,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
      ),
      body1: TextStyle(
        fontSize: 14,
      ),
    ),
  );
}
