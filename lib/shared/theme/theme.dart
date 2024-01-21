import 'package:google_fonts/google_fonts.dart';
import 'package:realm_app/shared/theme/theme_config.dart';
import 'package:flutter/material.dart';

ThemeData getDefaultTheme() {
  return ThemeData().copyWith(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    appBarTheme: AppBarTheme(
      elevation: 0.6,
      titleTextStyle: GoogleFonts.ibmPlexSans(
        color: Color(0xff495057),
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Color(0xffffffff),
      iconTheme: IconThemeData(color: Color(0xff495057)),
      actionsIconTheme: IconThemeData(
        color: Color(0xff495057),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.blueGrey[900]!,
    ),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.blueGrey[900]!,
    ),
    textTheme: TextTheme(
      titleSmall: GoogleFonts.ibmPlexSans(
        color: textColor,
      ),
      titleMedium: GoogleFonts.ibmPlexSans(
        color: textColor,
      ),
      titleLarge: GoogleFonts.ibmPlexSans(
        color: textColor,
      ),
      bodyLarge: GoogleFonts.ibmPlexSans(
        color: textColor,
      ),
      bodySmall: GoogleFonts.ibmPlexSans(
        color: textColor,
      ),
      bodyMedium: GoogleFonts.ibmPlexSans(
        color: textColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 4.0,
      ),
      hoverColor: Colors.transparent,
      errorMaxLines: 1,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Colors.grey[300]!,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: Colors.grey[300]!,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: primaryColor,
        ),
      ),
      filled: true,
      fillColor: inputColor,
    ),
    cardTheme: CardTheme(
      elevation: 0.6,
      color: Color(0xfff6f6f6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          width: 0.4,
          color: Colors.grey[300]!,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
  );
}
