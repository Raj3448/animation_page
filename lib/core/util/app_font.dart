import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static const double small = 12.0;
  static const double medium = 16.0;
  static const double large = 20.0;
  static const double extraLarge = 24.0;
  static const double huge = 32.0;

  static final TextStyle smallText = GoogleFonts.roboto(
    fontSize: small,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle mediumText = GoogleFonts.roboto(
    fontSize: medium,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle largeText = GoogleFonts.roboto(
    fontSize: large,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle extraLargeText = GoogleFonts.roboto(
    fontSize: extraLarge,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle hugeText = GoogleFonts.roboto(
    fontSize: huge,
    fontWeight: FontWeight.bold,
  );
}
