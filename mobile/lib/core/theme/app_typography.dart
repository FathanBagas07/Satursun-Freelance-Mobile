// lib/core/theme/app_typography.dart

import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  // Menggunakan 'NunitoSans' seperti yang sudah ada
  static const String fontFamily = 'NunitoSans';

  /// Headline 1 — Halaman utama, judul besar
  static const TextStyle headline1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 34,
    fontWeight: FontWeight.w900, // Extra Bold untuk kesan kuat
    color: AppColors.textDark,
  );

  /// Headline 2 — Judul section
  static const TextStyle headline2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w800, // Lebih tebal dari w700
    color: AppColors.textDark,
  );

  /// Title — Judul kecil pada card / dialog
  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700, // Lebih tebal dari w600
    color: AppColors.textDark,
  );

  /// Subtitle — Keterangan pendek
  static const TextStyle subtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600, // Sedikit lebih tebal dari w500
    color: AppColors.textLight,
  );

  /// Body — paragraf utama aplikasi
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  /// Body Small — paragraf kecil (form, hint, caption)
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textLight,
  );

  /// Button text
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700, // Lebih tebal dari w600
    color: Colors.white,
  );

  /// Italic text
  static const TextStyle italic = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: AppColors.textDark,
  );
}