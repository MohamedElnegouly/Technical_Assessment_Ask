import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(_loadInitialMode());

  static ThemeMode _loadInitialMode() {
    final box = Hive.box('settingsBox');
    final isDark = box.get('isDarkMode', defaultValue: false) as bool;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    Hive.box('settingsBox').put('isDarkMode', newMode == ThemeMode.dark);
    emit(newMode);
  }
}
