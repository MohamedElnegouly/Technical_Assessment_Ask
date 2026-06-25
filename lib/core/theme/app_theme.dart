import 'package:flutter/material.dart';
import 'package:technical_assessment_task/core/utils/app_colors.dart';

class AppTheme {
  static const _fontFamily = 'Poppins';
  static const _radius = 14.0;

  static RoundedRectangleBorder _shape([double radius = _radius]) =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));

  static ThemeData get light => _base(
        brightness: Brightness.light,
        scaffoldBackground: const Color(0xFFF6F7F9),
        appBarBackground: AppColors.primary,
        cardColor: Colors.white,
        textColor: const Color(0xFF1A1C1E),
        subtleTextColor: const Color(0xFF6B7280),
      );

  static ThemeData get dark => _base(
        brightness: Brightness.dark,
        scaffoldBackground: const Color(0xFF121212),
        appBarBackground: AppColors.darkBlue,
        cardColor: const Color(0xFF1E1E1E),
        textColor: const Color(0xFFECECEC),
        subtleTextColor: const Color(0xFFA1A1AA),
      );

  static ThemeData _base({
    required Brightness brightness,
    required Color scaffoldBackground,
    required Color appBarBackground,
    required Color cardColor,
    required Color textColor,
    required Color subtleTextColor,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
    );

    return ThemeData(
      brightness: brightness,
      useMaterial3: true,
      fontFamily: _fontFamily,
      scaffoldBackgroundColor: scaffoldBackground,
      colorScheme: colorScheme,
      cardColor: cardColor,
      dividerColor: subtleTextColor.withValues(alpha: 0.15),
      appBarTheme: AppBarTheme(
        backgroundColor: appBarBackground,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          fontFamily: _fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
        titleMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        bodyMedium: TextStyle(fontSize: 14, color: textColor),
        bodySmall: TextStyle(fontSize: 13, color: subtleTextColor),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 1.5,
        margin: EdgeInsets.zero,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        shape: _shape(),
      ),
      chipTheme: ChipThemeData(
        labelStyle: const TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        shape: _shape(20),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: _shape(),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.4),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: _shape(),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 3,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: subtleTextColor.withValues(alpha: 0.25)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: subtleTextColor.withValues(alpha: 0.25)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.6),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.darkBlue,
        contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        shape: _shape(12),
      ),
      dialogTheme: DialogThemeData(shape: _shape(20)),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
    );
  }
}
