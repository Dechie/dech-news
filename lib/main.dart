import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 102, 6, 247),
  surface: const Color.fromARGB(255, 56, 49, 66),
);

final theme = ThemeData().copyWith(
  scaffoldBackgroundColor: colorScheme.surface,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.merriweatherTextTheme().copyWith(
    titleSmall: GoogleFonts.merriweather(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.merriweather(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.merriweather(
      fontWeight: FontWeight.bold,
    ),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
