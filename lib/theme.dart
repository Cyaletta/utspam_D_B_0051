import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  // Pastel pink and pastel blue color scheme
  const pastelPink = Color(0xFFFFC1E3);
  const pastelBlue = Color(0xFFBCE0FF);
  const darkBlue = Color(0xFF2B4C6F);

  return ThemeData(
    primaryColor: pastelPink,
    colorScheme: ColorScheme.fromSeed(seedColor: pastelBlue),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: pastelPink,
      foregroundColor: Colors.black,
      elevation: 1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: pastelBlue,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: pastelPink.withOpacity(0.12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.black)),
  );
}
