import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData getLightTheme(BuildContext context) => ThemeData(
        primarySwatch: pinkMain,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context)
              .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
        ),
      );



  static ThemeData getDarkTheme(BuildContext context) => ThemeData(
    primarySwatch: pinkMain,
    textTheme: GoogleFonts.latoTextTheme(
      Theme.of(context)
          .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
    ),
  );

  static const MaterialColor pinkMain = MaterialColor(
    _pinkPrimaryValue,
    <int, Color>{
      50: Color(0xffffe5e7),
      100: Color(0xffff8085),
      200: Color(0xffff8085),
      300: Color(0xFFff4d54),
      400: Color(0xFFff1a24),
      500: Color(_pinkPrimaryValue),
      600: Color(0xFFe6000a),
      700: Color(0xFF800006),
      800: Color(0xFF4d0003),
      900: Color(0xFF1a0001),
    },
  );
  static const int _pinkPrimaryValue = 0xFF1A0001;

  static Color pink = const Color(0XFFff4d54);
  static Color black = const Color(0XFF191922);
  static Color charcoal = const Color(0XFF36454F);
  static Color darkBlue = const Color(0XFF001b3a);
  static Color darkBackground = const Color(0XFF001b3a);
}
