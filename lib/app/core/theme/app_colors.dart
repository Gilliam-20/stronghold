import 'package:flutter/material.dart';

/// STRONGHOLD brand palette.
///
/// Built around the material world of the gym itself — poured concrete,
/// raw steel, and the caution-yellow of chalk tins and loading-zone tape —
/// rather than a generic "dark mode + accent" default.
class AppColors {
  AppColors._();

  // Backgrounds
  static const Color concrete = Color(0xFF16171A); // primary page background
  static const Color concreteDeep = Color(0xFF0E0F11); // footer / deepest layer
  static const Color surface = Color(0xFF1E1F22); // cards, panels
  static const Color surfaceAlt = Color(0xFF26272B); // hovered / raised surface

  // Accents
  static const Color caution = Color(0xFFE8C547); // primary — chalk / hazard yellow
  static const Color cautionDim = Color(0xFFB89A38);
  static const Color rust = Color(0xFFC1502E); // secondary — worn iron / rust

  // Text
  static const Color bone = Color(0xFFEDEAE2); // primary text on dark
  static const Color fog = Color(0xFF95989E); // secondary / muted text
  static const Color fogDim = Color(0xFF616469);

  // Lines & structure
  static const Color hairline = Color(0xFF313236);
  static const Color hairlineStrong = Color(0xFF3E4045);

  // Status
  static const Color success = Color(0xFF6FA36B);
  static const Color error = Color(0xFFD9634F);

  // On-accent text (used on caution-yellow surfaces)
  static const Color onCaution = Color(0xFF16171A);
}
