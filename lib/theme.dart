import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color.fromARGB(255, 204, 211, 211),
    primary: Color.fromARGB(255, 191, 82, 43),
    secondary:Color.fromARGB(255, 204, 211, 211),
    tertiary: Colors.black,
    surface: Colors.black,
  ),
);

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      surface: Colors.black,
      background: Color.fromARGB(255, 20, 19, 20),
      primary: Color.fromARGB(255, 191, 82, 43),
      secondary: Color.fromARGB(255, 204, 211, 211),
      tertiary: Color.fromARGB(255, 204, 211, 211),
    ));
