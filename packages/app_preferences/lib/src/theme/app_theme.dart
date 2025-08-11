import 'package:app_preferences/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Application theme configuration and management
///
/// This class provides a centralized way to define and manage the application's
/// theme configuration for both light and dark modes. It uses Material 3 design
/// principles and provides consistent theming across the application.
///
/// The theme is built using a seed color (orange) that generates a
/// cohesive color scheme for both light and dark variants.
///
/// Example usage:
/// ```dart
/// MaterialApp(
///   theme: AppTheme.lightTheme,
///   darkTheme: AppTheme.darkTheme,
///   themeMode: ThemeMode.system,
/// )
/// ```
class AppTheme {
  /// Creates an instance of [AppTheme]
  ///
  /// This constructor is const to allow for efficient instantiation
  /// and static access to theme configurations.
  const AppTheme();

  /// Gets the light theme configuration
  ///
  /// Returns a pre-configured [ThemeData] for light mode using Material 3
  /// design principles. The theme is generated from an orange seed color.
  ///
  /// Returns:
  /// A [ThemeData] configured for light mode
  static ThemeData get lightTheme => const AppTheme().toLightTheme();

  /// Gets the dark theme configuration
  ///
  /// Returns a pre-configured [ThemeData] for dark mode using Material 3
  /// design principles. The theme is generated from an orange seed color
  /// with dark brightness.
  ///
  /// Returns:
  /// A [ThemeData] configured for dark mode
  static ThemeData get darkTheme => const AppTheme().toDarkTheme();

  /// Converts the theme configuration to light theme data
  ///
  /// Creates a complete [ThemeData] configuration for light mode with:
  /// - Material 3 design system enabled
  /// - Color scheme generated from orange seed color
  /// - Custom AppBar theme with inverse primary background
  /// - White text colors for contrast
  ///
  /// Returns:
  /// A fully configured [ThemeData] for light mode
  ThemeData toLightTheme() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: XINXINColors.orange,
      // 可読性を向上させるための適切な色配置
      primary: XINXINColors.orange,
      onPrimary: XINXINColors.white,
      secondary: XINXINColors.orange,
      onSecondary: XINXINColors.white,
      surface: XINXINColors.white,
      onSurface: XINXINColors.black,
      error: Colors.red,
      onError: XINXINColors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: XINXINColors.orange,
        foregroundColor: XINXINColors.white,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: XINXINColors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: XINXINColors.white,
        elevation: 2,
        shadowColor: XINXINColors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: XINXINColors.orange.withValues(alpha: 0.1),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: XINXINColors.orange,
          foregroundColor: XINXINColors.white,
          elevation: 2,
          shadowColor: XINXINColors.black.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: XINXINColors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: XINXINColors.orange,
          side: const BorderSide(color: XINXINColors.orange),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: XINXINColors.black.withValues(alpha: 0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: XINXINColors.orange, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: XINXINColors.black.withValues(alpha: 0.2),
          ),
        ),
        filled: true,
        fillColor: XINXINColors.white,
      ),
      dividerTheme: DividerThemeData(
        color: XINXINColors.black.withValues(alpha: 0.1),
        thickness: 1,
      ),
    );
  }

  /// Converts the theme configuration to dark theme data
  ///
  /// Creates a complete [ThemeData] configuration for dark mode with:
  /// - Material 3 design system enabled
  /// - Color scheme generated from orange seed color with dark brightness
  /// - Custom AppBar theme with inverse primary background
  /// - White text colors optimized for dark mode
  ///
  /// Returns:
  /// A fully configured [ThemeData] for dark mode
  ThemeData toDarkTheme() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: XINXINColors.orange,
      brightness: Brightness.dark,
      // ダークモード用の色配置
      primary: XINXINColors.orange,
      onPrimary: XINXINColors.black,
      secondary: XINXINColors.orange,
      onSecondary: XINXINColors.black,
      surface: XINXINColors.black,
      onSurface: XINXINColors.white,
      error: Colors.red,
      onError: XINXINColors.black,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: XINXINColors.black,
        foregroundColor: XINXINColors.white,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: XINXINColors.orange,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: XINXINColors.black,
        elevation: 4,
        shadowColor: XINXINColors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: XINXINColors.orange.withOpacity(0.3),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: XINXINColors.orange,
          foregroundColor: XINXINColors.black,
          elevation: 2,
          shadowColor: XINXINColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: XINXINColors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: XINXINColors.orange,
          side: const BorderSide(color: XINXINColors.orange),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: XINXINColors.white.withValues(alpha: 0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: XINXINColors.orange, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: XINXINColors.white.withValues(alpha: 0.3),
          ),
        ),
        filled: true,
        fillColor: XINXINColors.black,
      ),
      dividerTheme: DividerThemeData(
        color: XINXINColors.white.withValues(alpha: 0.2),
        thickness: 1,
      ),
    );
  }
}
