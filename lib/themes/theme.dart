import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade800,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color.fromARGB(255, 25, 25, 25),
    primary: const Color.fromARGB(255, 45, 45, 45),
    secondary: const Color.fromARGB(255, 77, 77, 77),
    inversePrimary: Colors.grey.shade300,
  ),
);

final themeProvider = StateProvider<ThemeData>((ref) {
  return lightMode;
});
