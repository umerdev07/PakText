import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static TextTheme get textTheme => TextTheme(
    bodyLarge: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
    bodyMedium: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
    titleLarge: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
  );
}