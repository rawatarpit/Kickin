import 'package:flutter/material.dart';

import 'kickin_colors.dart';
import 'kickin_spacing.dart';
import 'kickin_typography.dart';
import 'kickin_radius.dart';

class KickinTheme {
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: KickinTypography.fontFamily,
      scaffoldBackgroundColor: KickinColors.background,

      colorScheme: const ColorScheme.dark(
        primary: KickinColors.primary,
        surface: KickinColors.surface,
        error: KickinColors.error,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: KickinColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: KickinColors.textPrimary),
      ),

      textTheme: const TextTheme(
        headlineLarge: KickinTypography.h1,
        headlineMedium: KickinTypography.h2,
        bodyMedium: KickinTypography.body,
        bodySmall: KickinTypography.bodyMuted,
        labelSmall: KickinTypography.caption,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: KickinColors.surface,
        hintStyle: const TextStyle(color: KickinColors.textMuted),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: KickinSpacing.md,
          vertical: KickinSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KickinRadius.md),
          borderSide: const BorderSide(color: KickinColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KickinRadius.md),
          borderSide: const BorderSide(color: KickinColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(KickinRadius.md),
          borderSide: const BorderSide(color: KickinColors.primary),
        ),
      ),

      dividerColor: KickinColors.border,
    );
  }
}
