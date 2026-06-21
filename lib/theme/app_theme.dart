import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Plum brand colors — warm, professional, works for a tradesman app
class PlumColors {
  PlumColors._();

  // Primary: Deep teal — trust, professionalism
  static const Color primary = Color(0xFF0D7377);
  static const Color primaryLight = Color(0xFF14A3A8);
  static const Color primaryDark = Color(0xFF095456);

  // Secondary: Warm amber — energy, action
  static const Color secondary = Color(0xFFF59E0B);
  static const Color secondaryLight = Color(0xFFFBBF24);
  static const Color secondaryDark = Color(0xFFD97706);

  // Surfaces
  static const Color background = Color(0xFFF8FAFB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);
  static const Color cardBorder = Color(0xFFE2E8F0);

  // Text
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textHint = Color(0xFF94A3B8);

  // Status
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Specific feature colors
  static const Color billColor = Color(0xFF3B82F6);
  static const Color quotationColor = Color(0xFFF97316);
  static const Color paymentColor = Color(0xFFEF4444);
  static const Color showcaseColor = Color(0xFF8B5CF6);
  static const Color calculatorColor = Color(0xFF06B6D4);
  static const Color customerColor = Color(0xFF10B981);
}

class PlumTheme {
  PlumTheme._();

  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: PlumColors.primary,
        onPrimary: Colors.white,
        primaryContainer: Color(0xFFB2DFDB),
        onPrimaryContainer: PlumColors.primaryDark,
        secondary: PlumColors.secondary,
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFFFEF3C7),
        onSecondaryContainer: PlumColors.secondaryDark,
        surface: PlumColors.surface,
        onSurface: PlumColors.textPrimary,
        surfaceContainerHighest: PlumColors.surfaceVariant,
        error: PlumColors.error,
        onError: Colors.white,
      ),

      scaffoldBackgroundColor: PlumColors.background,

      // Text theme
      textTheme: baseTextTheme.copyWith(
        headlineLarge: baseTextTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: PlumColors.textPrimary,
          letterSpacing: -0.5,
        ),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: PlumColors.textPrimary,
          letterSpacing: -0.3,
        ),
        headlineSmall: baseTextTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: PlumColors.textPrimary,
        ),
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: PlumColors.textPrimary,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: PlumColors.textPrimary,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          color: PlumColors.textPrimary,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          color: PlumColors.textSecondary,
        ),
        bodySmall: baseTextTheme.bodySmall?.copyWith(
          color: PlumColors.textHint,
        ),
        labelLarge: baseTextTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),

      // AppBar
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: PlumColors.surface,
        foregroundColor: PlumColors.textPrimary,
        centerTitle: false,
        titleTextStyle: baseTextTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: PlumColors.textPrimary,
          fontSize: 20,
        ),
      ),

      // Cards
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: PlumColors.cardBorder, width: 1),
        ),
        color: PlumColors.surface,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),

      // Bottom Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: PlumColors.surface,
        selectedItemColor: PlumColors.primary,
        unselectedItemColor: PlumColors.textHint,
        elevation: 8,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),

      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: PlumColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: CircleBorder(),
      ),

      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PlumColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: PlumColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: PlumColors.error, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: const TextStyle(color: PlumColors.textHint),
      ),

      // Elevated buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PlumColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),

      // Outlined buttons
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: PlumColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: PlumColors.primary),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),

      // Text buttons
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: PlumColors.primary,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),

      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: PlumColors.surfaceVariant,
        selectedColor: PlumColors.primary.withValues(alpha: 0.15),
        labelStyle: const TextStyle(fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),

      // Bottom sheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: PlumColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        showDragHandle: true,
      ),

      // Dialogs
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: PlumColors.surface,
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: PlumColors.cardBorder,
        thickness: 1,
        space: 1,
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: PlumColors.textPrimary,
      ),

      // Page transitions — fast slide for speed-first philosophy
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
