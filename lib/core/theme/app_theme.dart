import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get theme {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonRed,
        secondary: AppColors.purple,
        surface: AppColors.black,
      ),
      scaffoldBackgroundColor: AppColors.black,
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
    );
  }
}
