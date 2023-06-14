import 'package:flutter/material.dart';

var lightThemeData = ThemeData(
    colorSchemeSeed: Colors.blue,
    textTheme: const TextTheme(labelLarge: TextStyle(color: Colors.white70), ),
    brightness: Brightness.light,);

var darkThemeData = ThemeData(
    colorSchemeSeed: Colors.blue,
    textTheme: TextTheme(labelLarge: TextStyle(color: Colors.black54)),
    brightness: Brightness.dark,);
