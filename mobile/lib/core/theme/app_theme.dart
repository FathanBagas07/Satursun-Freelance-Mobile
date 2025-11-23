import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

final satursunColorScheme = ColorScheme.light(
  // Primary (Warna Dominan)
  primary: AppColors.saturSunBlue,
  onPrimary: AppColors.backgroundWhite,

  // Secondary (Warna Aksen/Penekanan)
  secondary: AppColors.saturSunOrange,
  onSecondary: AppColors.backgroundWhite,

  // Surface (Latar Belakang Card/Permukaan)
  surface: AppColors.backgroundWhite,
  onSurface: AppColors.textDark,

  // Error (Warna Error/Peringatan)
  error: AppColors.saturSunRed,
  onError: AppColors.backgroundWhite,
);


final satursunAppTheme = ThemeData(
  useMaterial3: true,
  fontFamily: AppTypography.fontFamily,
  // Menggunakan ColorScheme yang telah didefinisikan
  colorScheme: satursunColorScheme,
  appBarTheme: AppBarTheme(
    backgroundColor: satursunColorScheme.primary,
    foregroundColor: satursunColorScheme.onPrimary,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: const TextStyle(
      fontSize: 18, 
      fontWeight: FontWeight.w600,
      color: AppColors.backgroundWhite,
    ),
  ),

  // Typography
  textTheme: TextTheme(
    displayLarge: AppTypography.headline1,
    displayMedium: AppTypography.headline2,
    titleLarge: AppTypography.title,
    titleMedium: AppTypography.subtitle,
    bodyLarge: AppTypography.body,
    bodySmall: AppTypography.bodySmall,
    labelLarge: AppTypography.button,
    labelSmall: AppTypography.italic,
  ),

  // Button Theme (ElevatedButton)
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: satursunColorScheme.primary,
      foregroundColor: satursunColorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  ),
  
  // Card Theme
  cardTheme: CardThemeData(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    margin: EdgeInsets.zero,
  ),

  // Bottom Navigation Bar Theme (Opsional, tapi membantu konsistensi)
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: satursunColorScheme.primary,
    unselectedItemColor: AppColors.textLight,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppColors.backgroundWhite,
    elevation: 0,
  ),
);