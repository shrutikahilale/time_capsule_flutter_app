import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue, // Primary color for the app
  hintColor: Colors.amber,
  iconTheme: const IconThemeData(
    color: Colors.black, // Set the default color for icons in light theme
    size: 24, // Set the default size for icons in light theme
  ),
  brightness: Brightness.light, // Brightness (light or dark theme)
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.black),
    titleLarge: TextStyle(fontSize: 24.0, color: Colors.black),
    titleMedium: TextStyle(fontSize: 18.0, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 16.0, color: Colors.black),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue, // Color of the button
    textTheme: ButtonTextTheme.primary, // Text color for buttons
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.blue),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.blue),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.blueAccent),
    ),
    hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
    labelStyle: const TextStyle(color: Colors.blue),
  ),
  cardColor: Colors.black12,
  canvasColor: Colors.black12,
  fontFamily: GoogleFonts.kumbhSans().fontFamily,
);

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.blueGrey, // Primary color for the app
  hintColor: Colors.orange, // Accent color for the app
  brightness: Brightness.dark, // Brightness (light or dark theme)
  iconTheme: const IconThemeData(
    color: Colors.white, // Set the default color for icons in dark theme
    size: 24, // Set the default size for icons in dark theme
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: TextStyle(fontSize: 24.0, color: Colors.white),
    titleMedium: TextStyle(fontSize: 18.0, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 16.0, color: Colors.white),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue, // Color of the button
    textTheme: ButtonTextTheme.primary, // Text color for buttons
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[800],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.orange.shade50),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.orange.shade50),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.orange.shade50),
    ),
    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16.0),
    labelStyle: TextStyle(color: Colors.grey[400]),
  ),
  cardColor: Colors.white10,
  canvasColor: Colors.blueGrey.shade800,
  fontFamily: GoogleFonts.kumbhSans().fontFamily,
);
