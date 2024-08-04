import 'package:flutter/material.dart';

class AppColor {
  static const primary = MaterialColor(
    0xFF00579B,
    <int, Color>{
      50: Color(0xFFE5EEF5),
      100: Color(0xFFCCDDEB),
      200: Color(0xFFB2CDE1),
      300: Color(0xFF99BCD7),
      400: Color(0xFF80ABCD),
      500: Color(0xFF669AC3),
      600: Color(0xFF4D89B9),
      700: Color(0xFF3379AF),
      800: Color(0xFF1A68A5),
      900: Color(0xFF00579B),
    },
  );

  static const secondary = MaterialColor(
    0xff6BB7FF,
    <int, Color>{
      50: Color(0xFFEAF5FF),
      100: Color(0xFFD5EAFF),
      200: Color(0xFFC0E0FF),
      300: Color(0xFFABD6FF),
      400: Color(0xFF95CBFF),
      500: Color(0xFF80C1FF),
      600: Color(0xFF6BB7FF),
      700: Color(0xFF56ADFF),
      800: Color(0xFF41A2FF),
      900: Color(0xFF2C98FF),
    },
  );

  static const neutral = MaterialColor(
    0xff4B5563,
    <int, Color>{
      50: Color(0xFFF9FAFB),
      100: Color(0xFFF3F4F6),
      200: Color(0xFFE5E7EB),
      300: Color(0xFFD1D5DB),
      400: Color(0xFF9CA3AF),
      500: Color(0xFF6B7280),
      600: Color(0xFF4B5563),
      700: Color(0xFF374151),
      800: Color(0xFF1F2937),
      900: Color(0xFF111827),
    },
  );

  // Shortcut
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF1F2024);
}
