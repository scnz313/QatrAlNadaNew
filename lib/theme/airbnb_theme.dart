import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AirbnbTheme {
  // Primary Colors
  static const Color primaryRed = Color(0xFFFF385C); // Airbnb's signature red
  static const Color primaryDark = Color(0xFF222222);
  static const Color primaryWhite = Color(0xFFFFFFFF);
  
  // Neutral Colors
  static const Color gray100 = Color(0xFFF7F7F7);
  static const Color gray200 = Color(0xFFEBEBEB);
  static const Color gray300 = Color(0xFFDDDDDD);
  static const Color gray400 = Color(0xFFB0B0B0);
  static const Color gray500 = Color(0xFF717171);
  static const Color gray600 = Color(0xFF484848);
  static const Color gray700 = Color(0xFF222222);
  
  // Accent Colors
  static const Color accentGreen = Color(0xFF008A05);
  static const Color accentBlue = Color(0xFF428BFF);
  static const Color accentYellow = Color(0xFFFFB400);
  static const Color accentPurple = Color(0xFF914669);
  
  // Background Colors
  static const Color backgroundLight = Color(0xFFFFFFFD);
  static const Color backgroundGray = Color(0xFFF7F7F7);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  
  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x29000000);
  static const Color shadowDark = Color(0x3D000000);
  
  // Typography
  static TextTheme get textTheme {
    return TextTheme(
      // Display styles
      displayLarge: GoogleFonts.poppins(
        fontSize: 48,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.5,
        height: 1.2,
        color: primaryDark,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.3,
        color: primaryDark,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.3,
        color: primaryDark,
      ),
      
      // Headline styles
      headlineLarge: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.25,
        height: 1.4,
        color: primaryDark,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        height: 1.4,
        color: primaryDark,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.4,
        color: primaryDark,
      ),
      
      // Body styles
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.5,
        color: gray700,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.5,
        color: gray700,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.5,
        color: gray600,
      ),
      
      // Label styles
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.4,
        color: primaryDark,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.4,
        color: primaryDark,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.4,
        color: gray600,
      ),
    );
  }
  
  // Arabic Typography for content
  static TextTheme get arabicTextTheme {
    return TextTheme(
      displayLarge: const TextStyle(
        fontFamily: 'Noto',
        fontSize: 40,
        fontWeight: FontWeight.w700,
        height: 1.5,
        color: primaryDark,
      ),
      displayMedium: const TextStyle(
        fontFamily: 'Noto',
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: primaryDark,
      ),
      bodyLarge: const TextStyle(
        fontFamily: 'Noto',
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 2.0,
        color: gray700,
      ),
      bodyMedium: const TextStyle(
        fontFamily: 'Noto',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.8,
        color: gray700,
      ),
    );
  }
  
  // Box Shadows
  static List<BoxShadow> get lightShadow => const [
    BoxShadow(
      color: shadowLight,
      offset: Offset(0, 2),
      blurRadius: 8,
    ),
  ];
  
  static List<BoxShadow> get mediumShadow => const [
    BoxShadow(
      color: shadowMedium,
      offset: Offset(0, 4),
      blurRadius: 16,
    ),
  ];
  
  static List<BoxShadow> get heavyShadow => const [
    BoxShadow(
      color: shadowDark,
      offset: Offset(0, 8),
      blurRadius: 24,
    ),
  ];
  
  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  static const double radiusRound = 999.0;
  
  // Spacing
  static const double space2 = 2.0;
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;
  static const double space64 = 64.0;
  
  // Transitions
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  
  static const Curve animationCurve = Curves.easeInOutCubic;
  
  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryRed,
      scaffoldBackgroundColor: backgroundLight,
      
      colorScheme: const ColorScheme.light(
        primary: primaryRed,
        onPrimary: primaryWhite,
        secondary: primaryDark,
        onSecondary: primaryWhite,
        surface: surfaceWhite,
        onSurface: primaryDark,
        error: primaryRed,
        onError: primaryWhite,
      ),
      
      textTheme: textTheme,
      
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceWhite,
        foregroundColor: primaryDark,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineMedium,
        toolbarHeight: 64,
        scrolledUnderElevation: 1,
        shadowColor: shadowLight,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryRed,
          foregroundColor: primaryWhite,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryDark,
          side: const BorderSide(color: gray300, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryDark,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      
      cardTheme: const CardThemeData(
        color: surfaceWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radiusMedium)),
          side: BorderSide(color: gray200, width: 1),
        ),
        margin: EdgeInsets.all(0),
      ),
      
      iconTheme: const IconThemeData(
        color: primaryDark,
        size: 24,
      ),
      
      dividerTheme: const DividerThemeData(
        color: gray200,
        thickness: 1,
        space: 0,
      ),
      
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceWhite,
        selectedItemColor: primaryRed,
        unselectedItemColor: gray500,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      
      drawerTheme: const DrawerThemeData(
        backgroundColor: surfaceWhite,
        elevation: 0,
        width: 280,
      ),
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryRed,
      scaffoldBackgroundColor: const Color(0xFF121212),
      
      colorScheme: const ColorScheme.dark(
        primary: primaryRed,
        onPrimary: primaryWhite,
        secondary: primaryDark,
        onSecondary: primaryWhite,
        surface: Color(0xFF1E1E1E),
        onSurface: primaryWhite,
        error: primaryRed,
        onError: primaryWhite,
        background: Color(0xFF121212),
      ),
      
      textTheme: textTheme.copyWith(
        bodyLarge: textTheme.bodyLarge?.copyWith(color: primaryWhite),
        bodyMedium: textTheme.bodyMedium?.copyWith(color: primaryWhite),
        headlineLarge: textTheme.headlineLarge?.copyWith(color: primaryWhite),
        headlineMedium: textTheme.headlineMedium?.copyWith(color: primaryWhite),
        titleLarge: textTheme.titleLarge?.copyWith(color: primaryWhite),
        titleMedium: textTheme.titleMedium?.copyWith(color: primaryWhite),
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: primaryWhite,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineMedium?.copyWith(color: primaryWhite),
        toolbarHeight: 64,
        scrolledUnderElevation: 1,
        shadowColor: Colors.black,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryRed,
          foregroundColor: primaryWhite,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: primaryWhite,
          ),
        ),
      ),
      
      cardTheme: const CardThemeData(
        color: Color(0xFF1E1E1E),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radiusMedium)),
          side: BorderSide(color: Color(0xFF333333), width: 1),
        ),
        margin: EdgeInsets.all(0),
      ),
      
      iconTheme: const IconThemeData(
        color: primaryWhite,
        size: 24,
      ),
      
      dividerTheme: const DividerThemeData(
        color: Color(0xFF333333),
        thickness: 1,
        space: 0,
      ),
      
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color(0xFF1E1E1E),
        elevation: 0,
        width: 280,
      ),
    );
  }
  
  static ThemeData get sepiaTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: const Color(0xFF8B4513), // Saddle Brown
      scaffoldBackgroundColor: const Color(0xFFFDF5E6), // Old Lace
      
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF8B4513), // Saddle Brown
        onPrimary: Color(0xFFFDF5E6), // Old Lace
        secondary: Color(0xFFD2691E), // Chocolate
        onSecondary: Color(0xFFFDF5E6), // Old Lace
        surface: Color(0xFFFAEBD7), // Antique White
        onSurface: Color(0xFF2F1B14), // Dark Brown
        error: Color(0xFFCD5C5C), // Indian Red
        onError: Color(0xFFFDF5E6), // Old Lace
        background: Color(0xFFFDF5E6), // Old Lace
      ),
      
      textTheme: textTheme.copyWith(
        bodyLarge: textTheme.bodyLarge?.copyWith(
          color: const Color(0xFF2F1B14), // Dark Brown
          fontFamily: 'Georgia',
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF2F1B14), // Dark Brown
          fontFamily: 'Georgia',
        ),
        headlineLarge: textTheme.headlineLarge?.copyWith(
          color: const Color(0xFF8B4513), // Saddle Brown
          fontFamily: 'Georgia',
        ),
        headlineMedium: textTheme.headlineMedium?.copyWith(
          color: const Color(0xFF8B4513), // Saddle Brown
          fontFamily: 'Georgia',
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          color: const Color(0xFF8B4513), // Saddle Brown
          fontFamily: 'Georgia',
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          color: const Color(0xFF8B4513), // Saddle Brown
          fontFamily: 'Georgia',
        ),
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFFFAEBD7), // Antique White
        foregroundColor: const Color(0xFF8B4513), // Saddle Brown
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineMedium?.copyWith(
          color: const Color(0xFF8B4513), // Saddle Brown
          fontFamily: 'Georgia',
        ),
        toolbarHeight: 64,
        scrolledUnderElevation: 1,
        shadowColor: const Color(0x1A8B4513),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8B4513), // Saddle Brown
          foregroundColor: const Color(0xFFFDF5E6), // Old Lace
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFFFDF5E6), // Old Lace
            fontFamily: 'Georgia',
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF8B4513), // Saddle Brown
          side: const BorderSide(color: Color(0xFFD2691E), width: 1), // Chocolate
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF8B4513), // Saddle Brown
            fontFamily: 'Georgia',
          ),
        ),
      ),
      
      cardTheme: const CardThemeData(
        color: Color(0xFFFAEBD7), // Antique White
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radiusMedium)),
          side: BorderSide(color: Color(0xFFDEB887), width: 1), // Burlywood
        ),
        margin: EdgeInsets.all(0),
      ),
      
      iconTheme: const IconThemeData(
        color: Color(0xFF8B4513), // Saddle Brown
        size: 24,
      ),
      
      dividerTheme: const DividerThemeData(
        color: Color(0xFFDEB887), // Burlywood
        thickness: 1,
        space: 0,
      ),
      
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color(0xFFFAEBD7), // Antique White
        elevation: 0,
        width: 280,
      ),
    );
  }
}