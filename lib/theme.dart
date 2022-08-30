import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Constants.dart';

final lightThemData = ThemeData(
    primarySwatch: primarySwatch,
    scaffoldBackgroundColor: whiteColor,
    appBarTheme: appBarThemeData,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme));

final darkThemData = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primarySwatch,
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
);

final appBarThemeData =
    AppBarTheme(color: whiteColor, foregroundColor: blackColor);
