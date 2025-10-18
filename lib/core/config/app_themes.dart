import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppThemes {
  // --- Common Text Theme for both light and dark modes ---
  // We define it once and then apply specific colors.
  static const _baseTextTheme = TextTheme(
    // For large headlines
    headlineLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
      fontSize: 28,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 24,
    ),
    // For titles in AppBars or sections
    titleLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),
    // For standard body text
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.5, // Line height for better readability
    ),
    // For slightly smaller body text or captions
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.4,
    ),
    // For the smallest text, like metadata or helper text
    bodySmall: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1.3,
    ),
    // For button text
    labelLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
  );

  // --- Light Theme Definition ---
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.lightBackground,
    fontFamily: 'Poppins',
    // Apply and customize the text theme for light mode
    textTheme: _baseTextTheme
        .apply(
          bodyColor: AppColors.lightPrimaryText,
          displayColor: AppColors.lightPrimaryText,
        )
        .copyWith(
          // Custom color for secondary text elements
          bodyMedium: _baseTextTheme.bodyMedium?.copyWith(
            color: AppColors.lightSecondaryText,
          ),
          bodySmall: _baseTextTheme.bodySmall?.copyWith(
            color: AppColors.lightSecondaryText,
          ),
        ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightSurface,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.lightPrimaryText),
      titleTextStyle: TextStyle(
        color: AppColors.lightPrimaryText,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor:
          AppColors.lightSurface, // Changed to surface for better contrast
      hintStyle: TextStyle(color: AppColors.lightSecondaryText),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: _baseTextTheme.labelLarge, // Use textTheme
      ),
    ),
  );

  // --- Dark Theme Definition ---
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.darkBackground,
    fontFamily: 'Poppins',
    // Apply and customize the text theme for dark mode
    textTheme: _baseTextTheme
        .apply(
          bodyColor: AppColors.darkPrimaryText,
          displayColor: AppColors.darkPrimaryText,
        )
        .copyWith(
          // Custom color for secondary text elements
          bodyMedium: _baseTextTheme.bodyMedium?.copyWith(
            color: AppColors.darkSecondaryText,
          ),
          bodySmall: _baseTextTheme.bodySmall?.copyWith(
            color: AppColors.darkSecondaryText,
          ),
        ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.darkPrimaryText),
      titleTextStyle: TextStyle(
        color: AppColors.darkPrimaryText,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      hintStyle: TextStyle(color: AppColors.darkSecondaryText),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: _baseTextTheme.labelLarge, // Use textTheme
      ),
    ),
  );
}
