import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  final colorSeed = Colors.deepPurple; //*0xff es el # de rgb
  
  ThemeData getTheme() => ThemeData(
    //* general
    useMaterial3: true,
    colorSchemeSeed: colorSeed,

    appBarTheme: AppBarTheme(
      backgroundColor: colorSeed.withAlpha(120)
    ),

    //* texts
    textTheme: TextTheme(
      titleLarge: GoogleFonts.montserratAlternates()
          .copyWith( color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold ),
      titleMedium: GoogleFonts.montserratAlternates()
          .copyWith( color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold ),
      titleSmall: GoogleFonts.montserratAlternates()
          .copyWith( color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold ),
      bodyLarge: GoogleFonts.montserratAlternates()
          .copyWith( color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold ),
      bodyMedium: GoogleFonts.montserratAlternates()
          .copyWith( color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold ),
      bodySmall: GoogleFonts.montserratAlternates()
          .copyWith( color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(30)
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30)
      ),
    ),

  );

}