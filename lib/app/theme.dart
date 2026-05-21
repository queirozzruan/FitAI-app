import 'package:fitai/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

abstract final class FitAiColors {
  static const royalBlue = Color(0xFF2563EB);
  static const white = Color(0xFFFFFFFF);
  static const background = Color(0xFFF8FAFC);
  static const border = Color(0xFFE2E8F0);
  static const textPrimary = Color(0xFF0F172A);
  static const textSecondary = Color(0xFF64748B);
  static const success = Color(0xFF22C55E);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
}

abstract final class FitAiTheme {
  static ThemeData get light {
    const colorScheme = ColorScheme.light(
      error: FitAiColors.error,
      onError: FitAiColors.white,
      onPrimary: FitAiColors.white,
      onSurface: FitAiColors.textPrimary,
      outline: FitAiColors.border,
      primary: FitAiColors.royalBlue,
      secondary: FitAiColors.textSecondary,
      surface: FitAiColors.white,
      tertiary: FitAiColors.success,
    );

    final textTheme = ThemeData.light(useMaterial3: true).textTheme
        .apply(
          bodyColor: FitAiColors.textPrimary,
          displayColor: FitAiColors.textPrimary,
        )
        .copyWith(
          displaySmall: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            height: 1.15,
          ),
          headlineMedium: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
          titleLarge: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.25,
          ),
          bodyLarge: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.45,
          ),
          bodyMedium: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        );

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: FitAiColors.border),
    );

    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: FitAiColors.background,
        foregroundColor: FitAiColors.textPrimary,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: FitAiColors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: FitAiColors.border),
        ),
      ),
      colorScheme: colorScheme,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: inputBorder,
        enabledBorder: inputBorder,
        errorBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: FitAiColors.error),
        ),
        focusedBorder: inputBorder.copyWith(
          borderSide: const BorderSide(
            color: FitAiColors.royalBlue,
            width: 1.4,
          ),
        ),
        filled: true,
        fillColor: FitAiColors.white,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: FitAiColors.textSecondary,
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: FitAiColors.textSecondary,
        ),
      ),
      scaffoldBackgroundColor: FitAiColors.background,
      textTheme: textTheme,
      useMaterial3: true,
    );
  }
}
