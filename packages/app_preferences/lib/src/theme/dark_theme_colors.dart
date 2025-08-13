import 'package:flutter/material.dart';

/// Dark theme specific color constants
///
/// This class defines color constants specifically optimized for dark theme
/// visibility and readability. These colors provide proper contrast ratios
/// and follow Material Design 3 dark theme guidelines.
class DarkThemeColors {
  /// Creates an instance of [DarkThemeColors]
  ///
  /// This constructor is private to prevent instantiation since this class
  /// only contains static constants.
  const DarkThemeColors._();

  /// Dark theme background color - softer than pure black
  ///
  /// HEX: #121212
  /// RGB: (18, 18, 18)
  /// Material Design 3 recommended dark background
  static const darkBackground = Color(0xFF121212);

  /// Dark theme surface color - slightly lighter for better contrast
  ///
  /// HEX: #1E1E1E
  /// RGB: (30, 30, 30)
  /// Used for app bars, navigation bars, and primary surfaces
  static const darkSurface = Color(0xFF1E1E1E);

  /// Dark theme card color - elevated surface for better separation
  ///
  /// HEX: #2C2C2C
  /// RGB: (44, 44, 44)
  /// Provides clear visual hierarchy for cards and elevated components
  static const darkCard = Color(0xFF2C2C2C);

  /// Light text color for dark theme - softer than pure white
  ///
  /// HEX: #E0E0E0
  /// RGB: (224, 224, 224)
  /// Primary text color that's easier on the eyes than pure white
  static const lightText = Color(0xFFE0E0E0);

  /// Secondary text color for dark theme
  ///
  /// HEX: #B0B0B0
  /// RGB: (176, 176, 176)
  /// Used for secondary text, hints, and disabled content
  static const secondaryText = Color(0xFFB0B0B0);
}
