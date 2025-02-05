// Theme configuration for QuickBite 2.0
// Contains all the styling and theming constants

import 'package:flutter/material.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Colors
  static const Color primaryColor = Colors.orange;
  static const Color secondaryColor = Colors.deepOrange;
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Colors.black87;

  // Text Styles
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
    fontFamily: 'SpaceGrotesk',
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: textColor,
    fontFamily: 'SpaceGrotesk',
  );

  // Spacing
  static const double spacing_xs = 4.0;
  static const double spacing_sm = 8.0;
  static const double spacing_md = 16.0;
  static const double spacing_lg = 24.0;

  // Border Radius
  static const double borderRadius = 8.0;
}
