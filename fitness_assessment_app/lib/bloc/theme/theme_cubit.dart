// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'theme_state.dart';

// class ThemeCubit extends Cubit<ThemeState> {
//   ThemeCubit() : super(const ThemeState()) {
//     _loadTheme();
//   }

//   static const _themeKey = 'theme_mode';

//   Future<void> _loadTheme() async {
//     final prefs = await SharedPreferences.getInstance();
//     final isDark = prefs.getBool(_themeKey) ?? false;
//     emit(ThemeState(themeMode: isDark ? ThemeMode.dark : ThemeMode.light));
//   }

//   Future<void> toggleTheme() async {
//     final newMode =
//         state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_themeKey, newMode == ThemeMode.dark);

//     emit(state.copyWith(themeMode: newMode));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState()) {
    _loadTheme();
  }

  static const _themeKey = 'theme_mode';

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeKey) ?? false;
    emit(ThemeState(themeMode: isDark ? ThemeMode.dark : ThemeMode.light));
  }

  Future<void> toggleTheme() async {
    final newMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, newMode == ThemeMode.dark);

    emit(state.copyWith(themeMode: newMode));
  }
}
