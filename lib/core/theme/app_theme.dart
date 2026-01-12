import 'package:flutter/material.dart';

/// App theme configuration
/// Provides consistent colors, text styles, and Material 3 theming
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Color Palette
  static const Color primaryColor = Color(0xFF2196F3); // Blue
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light grey
  static const Color cardColor = Color(0xFFFFFFFF); // White
  static const Color textPrimary = Color(0xFF2C3E50); // Dark grey
  static const Color textSecondary = Color(0xFF95A5A6); // Medium grey
  static const Color dividerColor = Color(0xFF64B5F6); // Light blue
  static const Color iconColor = Color(0xFF9E9E9E); // Grey
  static const Color iconActiveColor = Color(0xFF2196F3); // Blue
  static const Color shadowColor = Color(0x1A000000); // 10% black

  /// Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor,
        surface: cardColor,
        background: backgroundColor,
      ),

      // Scaffold
      scaffoldBackgroundColor: backgroundColor,

      // App Bar
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
        iconTheme: IconThemeData(color: textSecondary),
      ),

      // Card Theme
      cardTheme: const CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        margin: EdgeInsets.zero,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: iconColor, size: 24),

      // Text Theme
      textTheme: const TextTheme(
        // Quote text
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          color: textPrimary,
          height: 1.4,
          letterSpacing: 0.25,
        ),
        // Author name
        bodyLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textSecondary,
          letterSpacing: 1.5,
        ),
        // Button labels
        labelLarge: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textSecondary,
          letterSpacing: 0.5,
        ),
        // Time of day (MORNING)
        labelMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondary,
          letterSpacing: 2.0,
        ),
        // Page titles
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.15,
        ),
      ),

      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cardColor,
        selectedItemColor: iconActiveColor,
        unselectedItemColor: iconColor,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }

  /// Text Styles for custom use
  static const TextStyle quoteStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: textPrimary,
    height: 1.4,
    letterSpacing: 0.25,
  );

  static const TextStyle authorStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: textSecondary,
    letterSpacing: 1.5,
  );

  static const TextStyle timeOfDayStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    letterSpacing: 2.0,
  );

  /// Spacing constants
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  /// Border Radius constants
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 16.0;
  static const double radiusLarge = 24.0;
  static const double radiusXLarge = 32.0;

  /// Icon sizes
  static const double iconSizeSmall = 20.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
}
