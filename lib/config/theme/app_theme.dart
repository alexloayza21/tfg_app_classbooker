import 'package:flutter/material.dart';

const colorSeed = Color(0xff5A8CFF); //*0xff es el # de rgb

class AppTheme {
  
  ThemeData getTheme() => ThemeData(
    //* general
    useMaterial3: true,
    colorSchemeSeed: colorSeed,

    //* texts
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.white, fontSize: 20),
      titleMedium: TextStyle(color: Colors.white, fontSize: 15),
      titleSmall: TextStyle(color: Colors.white, fontSize: 12),
    )

  );

}