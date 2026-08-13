import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Type system for STRONGHOLD.
///
/// Two roles, deliberately not three: a heavy condensed display face for
/// headlines (system Arial Black / Helvetica Neue stack, tight negative
/// tracking, always uppercase) that reads like gym signage, and a plain
/// body face for anything meant to be read at length. A monospace face is
/// used sparingly for "data" moments — stats, prices, the ticker strip —
/// so numbers feel measured, like a scoreboard or a loaded bar.
///
/// NOTE: this intentionally avoids the google_fonts package. Fetching font
/// files over the network at first run has bitten this build before, so
/// everything here rides on fonts guaranteed to exist on the platform
/// (with graceful fallback). Drop real .ttf files into assets/fonts and
/// register them in pubspec.yaml if a specific display face is wanted later.
class AppTextStyles {
  AppTextStyles._();

  static const List<String> _displayFallback = [
    'Arial Black',
    'Helvetica Neue',
    'Segoe UI',
    'sans-serif',
  ];

  static const List<String> _dataFallback = [
    'Roboto Mono',
    'SF Mono',
    'Courier New',
    'monospace',
  ];

  // Display — hero / section headlines
  static TextStyle display({Color color = AppColors.bone, double size = 64}) {
    return TextStyle(
      fontFamilyFallback: _displayFallback,
      fontSize: size,
      fontWeight: FontWeight.w900,
      letterSpacing: -1.6,
      height: 0.98,
      color: color,
    );
  }

  static TextStyle headline({Color color = AppColors.bone, double size = 40}) {
    return TextStyle(
      fontFamilyFallback: _displayFallback,
      fontSize: size,
      fontWeight: FontWeight.w900,
      letterSpacing: -1.0,
      height: 1.02,
      color: color,
    );
  }

  static TextStyle titleCard({Color color = AppColors.bone, double size = 24}) {
    return TextStyle(
      fontFamilyFallback: _displayFallback,
      fontSize: size,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.4,
      height: 1.05,
      color: color,
    );
  }

  // Eyebrow / label — monospace, wide tracking, small caps feel
  static TextStyle eyebrow({Color color = AppColors.caution, double size = 12.5}) {
    return TextStyle(
      fontFamilyFallback: _dataFallback,
      fontSize: size,
      fontWeight: FontWeight.w600,
      letterSpacing: 3.2,
      color: color,
    );
  }

  // Data — stats, prices, ticker
  static TextStyle data({Color color = AppColors.bone, double size = 44}) {
    return TextStyle(
      fontFamilyFallback: _dataFallback,
      fontSize: size,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      color: color,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }

  static TextStyle dataSmall({Color color = AppColors.fog, double size = 13}) {
    return TextStyle(
      fontFamilyFallback: _dataFallback,
      fontSize: size,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.2,
      color: color,
    );
  }

  // Body copy
  static TextStyle body({Color color = AppColors.fog, double size = 16, FontWeight weight = FontWeight.w400}) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      height: 1.6,
      color: color,
    );
  }

  static TextStyle bodyStrong({Color color = AppColors.bone, double size = 17}) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w600,
      height: 1.5,
      color: color,
    );
  }

  static TextStyle button({Color color = AppColors.onCaution, double size = 14.5}) {
    return TextStyle(
      fontFamilyFallback: _dataFallback,
      fontSize: size,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.6,
      color: color,
    );
  }

  static TextStyle caption({Color color = AppColors.fogDim, double size = 12.5}) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
      color: color,
    );
  }
}
