import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clinics/core/config/app_themes.dart';

@injectable
class ThemeCubit extends Cubit<ThemeData> {
  static const String _themeKey = 'theme_mode';

  ThemeCubit() : super(AppThemes.lightTheme) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDarkMode = prefs.getBool(_themeKey) ?? false;
      emit(isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme);
    } catch (e) {
      // If there's an error loading preferences, use light theme as default
      emit(AppThemes.lightTheme);
    }
  }

  Future<void> toggleTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDarkMode = state.brightness == Brightness.dark;
      final newTheme = isDarkMode ? AppThemes.lightTheme : AppThemes.darkTheme;

      await prefs.setBool(_themeKey, !isDarkMode);
      emit(newTheme);
    } catch (e) {
      // If there's an error saving preferences, still toggle the theme
      emit(
        state.brightness == Brightness.dark
            ? AppThemes.lightTheme
            : AppThemes.darkTheme,
      );
    }
  }

  Future<void> setThemeMode(bool isDarkMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final newTheme = isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme;

      await prefs.setBool(_themeKey, isDarkMode);
      emit(newTheme);
    } catch (e) {
      // If there's an error saving preferences, still set the theme
      emit(isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme);
    }
  }

  bool get isDarkMode => state.brightness == Brightness.dark;
}
