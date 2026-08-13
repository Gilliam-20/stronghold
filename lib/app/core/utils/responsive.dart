import 'package:flutter/widgets.dart';

/// Breakpoints for the site. Kept intentionally simple — three bands —
/// because every section branches its layout tree explicitly rather than
/// relying on Wrap/Expanded tricks that don't hold up inside scrollables.
class Responsive {
  Responsive._();

  static const double mobileMax = 700;
  static const double tabletMax = 1080;
  static const double contentMaxWidth = 1240;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMax;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= mobileMax && w < tabletMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMax;

  /// Horizontal page gutter — tightens up on small screens.
  static double gutter(BuildContext context) {
    if (isMobile(context)) return 20;
    if (isTablet(context)) return 40;
    return 72;
  }
}
