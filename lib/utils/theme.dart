import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData mainTheme() => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(elevation: 0, color: Colors.transparent),
      textTheme: TextTheme(
        headline1: GoogleFonts.poppins(
          letterSpacing: 0.75,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF181B32),
        ),
        headline2: GoogleFonts.poppins(
          letterSpacing: 0.75,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF181B32),
        ),
        headline3: GoogleFonts.poppins(
          letterSpacing: 0.75,
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyText1: GoogleFonts.poppins(
          letterSpacing: 0.75,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF181B32),
        ),
      ),
    );
