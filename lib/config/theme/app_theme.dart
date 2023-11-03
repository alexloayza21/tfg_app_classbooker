import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const colorSeed = Color(0xff5A8CFF); //*0xff es el # de rgb

class AppTheme {
  
  ThemeData getTheme() => ThemeData(
    //* general
    useMaterial3: true,
    colorSchemeSeed: colorSeed,

    //* texts
    textTheme: TextTheme(
      titleLarge: GoogleFonts.montserratAlternates()
          .copyWith( color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold ),
      titleMedium: GoogleFonts.montserratAlternates()
          .copyWith( color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold ),
      titleSmall: GoogleFonts.montserratAlternates()
          .copyWith( color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold ),
    )

  );

}