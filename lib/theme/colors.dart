import 'package:flutter/material.dart';

class ThemeColors {

  static final MaterialColor primaryColor = const MaterialColor(
    _bluePrimaryValue,
    const <int, Color>{
      50: const Color(0xFF42A5F5),
      100: const Color(0xFF2196F3),
      200: const Color(0xFF1E88E5),
      300: const Color(0xFF1976D2),
      400: const Color(0xFF1565C0),
      500: const Color(_bluePrimaryValue),
      600: const Color(0xFF82B1FF),
      700: const Color(0xFF448AFF),
      800: const Color(0xFF2979FF),
      900: const Color(0xFF2962FF),
    },
  );
  static const int _bluePrimaryValue = 0xFF0D47A1;

  static final MaterialColor secondaryColor = const MaterialColor(
    _lightBlueSecondaryValue,
    const <int, Color>{
      50: const Color(0xFFFFFFFF),
      100: const Color(0xFFE0F7FA),
      200: const Color(0xFFE1F5FE),
      300: const Color(0xFFB3E5FC),
      400: const Color(0xFF81D4FA),
      500: const Color(_lightBlueSecondaryValue),
      600: const Color(0xFF29B6F6),
      700: const Color(0xFF03A9F4),
      800: const Color(0xFF039BE5),
      900: const Color(0xFF0288D1),
    },
  );
  static const int _lightBlueSecondaryValue = 0xFF4FC3F7;

  static const MaterialColor tertiaryColor = MaterialColor(
    _amberTertiaryValue,
    <int, Color>{
      50: Color(0xFFFFF8E1),
      100: Color(0xFFFFECB3),
      200: Color(0xFFFFE082),
      300: Color(0xFFFFD54F),
      400: Color(0xFFFFCA28),
      500: Color(_amberTertiaryValue),
      600: Color(0xFFFFB300),
      700: Color(0xFFFFA000),
      800: Color(0xFFFF8F00),
      900: Color(0xFFFF6F00),
    },
  );
  static const int _amberTertiaryValue = 0xFFFFC107;

}