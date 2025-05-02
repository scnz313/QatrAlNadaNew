import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define Theme identifiers
enum AppTheme { light, dark, sepia }

// --- Theme Data Definitions ---

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF4A90E2), // A clear blue
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF4A90E2),
    brightness: Brightness.light,
    background: Colors.white, // White background
    onBackground: Colors.black87, // Dark text on white
    surface: Colors.white, // Card/Surface colors
    onSurface: Colors.black87,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF4A90E2),
    foregroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
  ),
  cardTheme: CardTheme(
    elevation: 1,
    color: Colors.grey[50], // Slightly off-white cards
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black87, height: 1.5),
    titleLarge: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF4A90E2),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  dividerTheme: DividerThemeData(color: Colors.grey[300], thickness: 1),
  iconTheme: const IconThemeData(color: Color(0xFF4A90E2)),
  listTileTheme: const ListTileThemeData(iconColor: Color(0xFF4A90E2)),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF1F1F1F), // Very dark grey, near black
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFB89B72), // Use Sepia accent for contrast
    brightness: Brightness.dark,
    background: Colors.black, // Pure black background
    onBackground: Colors.white70, // Off-white text
    surface: const Color(0xFF121212), // Dark surface for cards
    onSurface: Colors.white70,
  ),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1F1F1F),
    foregroundColor: Colors.white70,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.w500),
  ),
  cardTheme: CardTheme(
    elevation: 1,
    color: const Color(0xFF121212),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white70, height: 1.5),
    titleLarge: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFB89B72), // Sepia accent button
      foregroundColor: Colors.black87, // Dark text on button
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  dividerTheme: DividerThemeData(color: Colors.grey[800], thickness: 1),
  iconTheme: const IconThemeData(color: Color(0xFFB89B72)), // Sepia accent icons
  listTileTheme: const ListTileThemeData(iconColor: Color(0xFFB89B72)),
);

final sepiaTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFB89B72),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFB89B72),
    brightness: Brightness.light,
    background: const Color(0xFFF8F3E7), // Existing sepia background
    onBackground: const Color(0xFF4B3F30), // Existing sepia text color
    surface: const Color(0xFFFDF8E4), // Existing card color
    onSurface: const Color(0xFF4B3F30),
  ),
  scaffoldBackgroundColor: const Color(0xFFF8F3E7),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFB89B72),
    foregroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
  ),
  cardTheme: CardTheme(
    elevation: 1,
    color: const Color(0xFFFDF8E4),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Color(0xFF4B3F30), height: 1.5),
    titleLarge: TextStyle(color: Color(0xFF4B3F30), fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFB89B72),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  dividerTheme: DividerThemeData(color: Colors.brown[200], thickness: 1),
  iconTheme: const IconThemeData(color: Color(0xFFB89B72)),
  listTileTheme: const ListTileThemeData(iconColor: Color(0xFFB89B72)),
);

// --- Theme Provider ---

// State Notifier for managing the theme state
class ThemeNotifier extends StateNotifier<AppTheme> {
  // TODO: Load initial theme from shared_preferences
  ThemeNotifier() : super(AppTheme.sepia); // Default theme

  void setTheme(AppTheme theme) {
    state = theme;
    // TODO: Persist theme preference (e.g., using shared_preferences)
  }

  ThemeData get currentThemeData {
    switch (state) {
      case AppTheme.light:
        return lightTheme;
      case AppTheme.dark:
        return darkTheme;
      case AppTheme.sepia:
      default:
        return sepiaTheme;
    }
  }
}

// The Riverpod provider
final themeProvider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) {
  return ThemeNotifier();
});
