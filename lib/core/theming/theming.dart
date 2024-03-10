import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightThemeData = ThemeData(
      primaryColor: const Color(0xff2B475E),
      primaryColorLight: Colors.blueGrey.shade400,
      scaffoldBackgroundColor: const Color(0xff2B475E),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xff2B475E)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.white),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
            minimumSize:
                const MaterialStatePropertyAll(Size(double.infinity, 60))),
      ),
      cardTheme: CardTheme(color: Colors.blueGrey.shade400));
}
