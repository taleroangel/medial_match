// ignore_for_file: prefer-match-file-name

import 'package:flutter/material.dart';

const medialMatchPrimary = Color(0xffb500ff);

ThemeData applicationTheme() => ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme(),
      textTheme: textTheme(),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );

ColorScheme colorScheme() {
  return ColorScheme.fromSeed(
    seedColor: medialMatchPrimary,
    brightness: Brightness.light,
  );
}

TextTheme textTheme() => const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'MedialNow',
        color: medialMatchPrimary,
      ),
      displayMedium: TextStyle(
        fontFamily: 'MedialNow',
        color: medialMatchPrimary,
      ),
      displaySmall: TextStyle(
        fontFamily: 'MedialNow',
      ),
      headlineSmall: TextStyle(
        fontFamily: 'MedialOne',
      ),
      headlineMedium: TextStyle(
        fontFamily: 'MedialOne',
      ),
      headlineLarge: TextStyle(
        fontFamily: 'MedialOne',
      ),
    );
