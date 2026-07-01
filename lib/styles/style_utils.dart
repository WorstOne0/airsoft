// Flutter packages
import 'package:flutter/material.dart';

/// Design tokens — spacing, radii, durations and semantic accent colors.
///
/// Pull colors from the theme's [ColorScheme] whenever possible; the semantic
/// accents below are for status indicators that are independent of the brand.
class StyleUtils {
  const StyleUtils();

  // ─────────────────────────────────────────────
  // SHAPES
  // ─────────────────────────────────────────────
  double get radiusSm => 8;
  double get radiusMd => 12;
  double get radiusLg => 16;
  double get radiusPill => 999;

  BorderRadius get borderRadiusSm => BorderRadius.circular(radiusSm);
  BorderRadius get borderRadiusMd => BorderRadius.circular(radiusMd);
  BorderRadius get borderRadiusLg => BorderRadius.circular(radiusLg);
  BorderRadius get borderRadiusPill => BorderRadius.circular(radiusPill);

  // ─────────────────────────────────────────────
  // SPACING
  // ─────────────────────────────────────────────
  double get space4 => 4;
  double get space8 => 8;
  double get space12 => 12;
  double get space16 => 16;
  double get space20 => 20;
  double get space24 => 24;
  double get space32 => 32;

  double get pagePadH => 20;
  double get cardGap => 12;
  double get sectionGap => 24;

  EdgeInsets get pagePadding => EdgeInsets.symmetric(horizontal: pagePadH, vertical: space16);

  // ─────────────────────────────────────────────
  // COLOR HELPERS — pull from theme, not hardcoded
  // ─────────────────────────────────────────────
  ColorScheme _cs(BuildContext c) => Theme.of(c).colorScheme;

  Color textMuted(BuildContext c) => _cs(c).onSurfaceVariant;
  Color textSubtle(BuildContext c) => _cs(c).onSurfaceVariant.withValues(alpha: 0.65);
  Color cardSurface(BuildContext c) => _cs(c).surfaceContainer;
  Color hairline(BuildContext c) => _cs(c).outlineVariant;

  // ─────────────────────────────────────────────
  // SEMANTIC ACCENTS — independent of brand color
  // ─────────────────────────────────────────────
  Color get accentRed => const Color(0xFFC83A3A);
  Color get accentOrange => const Color(0xFFEE9020);
  Color get accentAmber => const Color(0xFFE89540);
  Color get accentGreen => const Color(0xFF3A9B3E);
  Color get accentBlue => const Color(0xFF2F74C4);

  /// Status accents — use in badges, event states, alerts.
  Color get statusOpen => accentGreen;
  Color get statusSoon => accentAmber;
  Color get statusClosed => accentRed;

  // ─────────────────────────────────────────────
  // ANIMATION
  // ─────────────────────────────────────────────
  Duration get durationFast => const Duration(milliseconds: 150);
  Duration get durationNormal => const Duration(milliseconds: 240);
  Duration get durationSlow => const Duration(milliseconds: 400);
  Curve get curveStandard => Curves.easeOutCubic;
}
