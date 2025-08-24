import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => _customTheme;
}

final _customTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary,
    elevation: 0,
    foregroundColor: AppColors.secondary,
  ),
  cardTheme: CardThemeData(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: AppSpace.radius12),
    color: AppColors.lightGrey,
  ),
  scaffoldBackgroundColor: AppColors.secondary,
  primaryColor: AppColors.primary,
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData().textTheme),
);
