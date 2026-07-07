// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────
// COLOR SCHEMES
// AIRSOFT — warm military earth tones, three brand accents:
//   • primary    #453f2f  dark brown      → brand / app bar / focus
//   • secondary  #a3b565  olive           → selection: chips, nav pill, tags
//   • tertiary   #b5673d  terracotta      → the "signal": CTAs, FAB, likes
// Plus two brand extras (no ColorScheme slot): tan #c2a878, field #3f4128.
// Dark surfaces = warm charcoal→brown ramp, de-greened so the canvas reads
// warm-neutral (#15130d) instead of murky olive.
// ─────────────────────────────────────────────────────────────
const lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // Brand — dark brown primary
  primary: Color(0xff453f2f),
  surfaceTint: Color(0xff746a52),
  onPrimary: Color(0xfffdfbf3),
  primaryContainer: Color(0xff746a52),
  onPrimaryContainer: Color(0xfff6f1e2),

  // Secondary — olive (selection / chips / tags)
  secondary: Color(0xff57632f),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffdde4b4),
  onSecondaryContainer: Color(0xff2a3212),

  // Tertiary — terracotta signal (CTAs, FAB, likes)
  tertiary: Color(0xffb5673d),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xfff6d9c6),
  onTertiaryContainer: Color(0xff3c1a08),

  error: Color(0xffb3261e),
  onError: Color(0xffffffff),
  errorContainer: Color(0xfff9dedc),
  onErrorContainer: Color(0xff410e0b),

  // Surfaces — warm sand
  surface: Color(0xfff6f2e8),
  onSurface: Color(0xff211f18),
  onSurfaceVariant: Color(0xff4c4636),
  surfaceContainerLowest: Color(0xffffffff),
  surfaceContainerLow: Color(0xfff1ece0),
  surfaceContainer: Color(0xffeae4d5),
  surfaceContainerHigh: Color(0xffe3dccb),
  surfaceContainerHighest: Color(0xffddd5c2),
  surfaceDim: Color(0xffd7cfbc),
  surfaceBright: Color(0xfff6f2e8),

  outline: Color(0xff7c745f),
  outlineVariant: Color(0xffcdc5b0),

  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff37342b),
  inversePrimary: Color(0xffd6cbae),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Brand — light khaki for contrast on dark brown surfaces
  primary: Color(0xffd6cbae),
  surfaceTint: Color(0xffd6cbae),
  onPrimary: Color(0xff211f16),
  primaryContainer: Color(0xff453f2f),
  onPrimaryContainer: Color(0xffece3cd),

  // Secondary — olive (selection / chips / nav pill)
  secondary: Color(0xffa3b565),
  onSecondary: Color(0xff20260f),
  secondaryContainer: Color(0xff3a4a22),
  onSecondaryContainer: Color(0xffcfe08a),

  // Tertiary — terracotta signal (CTAs, FAB, likes)
  tertiary: Color(0xffb5673d),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xff5c3a22),
  onTertiaryContainer: Color(0xfff5d9bc),

  error: Color(0xfff2b8b5),
  onError: Color(0xff601410),
  errorContainer: Color(0xff8c1d18),
  onErrorContainer: Color(0xfff9dedc),

  // Surfaces — warm charcoal→brown ramp (de-greened). Scaffold = #15130d.
  surface: Color(0xff15130d),
  onSurface: Color(0xfff2efe4),
  onSurfaceVariant: Color(0xffa8a394),
  surfaceContainerLowest: Color(0xff100f0a),
  surfaceContainerLow: Color(0xff1b1a12),
  surfaceContainer: Color(0xff211f16),
  surfaceContainerHigh: Color(0xff2b2820),
  surfaceContainerHighest: Color(0xff35312a),
  surfaceDim: Color(0xff15130d),
  surfaceBright: Color(0xff34301e),

  outline: Color(0xff8f8a78),
  outlineVariant: Color(0xff2e2b1d),

  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffe6e1d3),
  inversePrimary: Color(0xff453f2f),
);

// ─────────────────────────────────────────────────────────────
// BRAND EXTRAS — no ColorScheme slot; reference these directly.
//   • Tan   #c2a878  earth accent: unit tags, badges, subtle highlights
//   • Field #3f4128  camo/hero backdrop behind media, headers, avatars
// ─────────────────────────────────────────────────────────────
const airsoftTan = Color(0xffc2a878);
const airsoftField = Color(0xff3f4128);

// ─────────────────────────────────────────────────────────────
// SHAPE
// ─────────────────────────────────────────────────────────────
OutlinedBorder get shapeSmall => RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
OutlinedBorder get shapeMedium => RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
OutlinedBorder get shapeLarge => RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));

// ─────────────────────────────────────────────────────────────
// TYPE — Oswald for display/headings (condensed, tactical),
// Barlow for body & UI, Anton for the stacked AIRSOFT wordmark.
// ─────────────────────────────────────────────────────────────
TextTheme textTheme(ColorScheme colors) {
  final base = GoogleFonts.barlowTextTheme().apply(bodyColor: colors.onSurface, displayColor: colors.onSurface);
  TextStyle os(TextStyle? s, FontWeight w) => GoogleFonts.oswald(textStyle: s, fontWeight: w, letterSpacing: 0.5);
  return base.copyWith(
    // Display & headlines → Oswald
    displayLarge: os(base.displayLarge, FontWeight.w700),
    displayMedium: os(base.displayMedium, FontWeight.w700),
    displaySmall: os(base.displaySmall, FontWeight.w700),
    headlineLarge: os(base.headlineLarge, FontWeight.w700),
    headlineMedium: os(base.headlineMedium, FontWeight.w600),
    headlineSmall: os(base.headlineSmall, FontWeight.w600),
    titleLarge: os(base.titleLarge, FontWeight.w600),
    // Titles / labels → Barlow (semibold)
    titleMedium: GoogleFonts.barlow(textStyle: base.titleMedium, fontWeight: FontWeight.w600),
    titleSmall: GoogleFonts.barlow(textStyle: base.titleSmall, fontWeight: FontWeight.w600),
    labelLarge: GoogleFonts.barlow(textStyle: base.labelLarge, fontWeight: FontWeight.w600),
    labelMedium: GoogleFonts.barlow(textStyle: base.labelMedium, fontWeight: FontWeight.w600),
    labelSmall: GoogleFonts.barlow(textStyle: base.labelSmall, fontWeight: FontWeight.w600),
  );
}

// Stacked AIRSOFT wordmark — use two Text widgets: Text('AIR') / Text('SOFT').
TextStyle logoTextStyle(Color color, {double fontSize = 34}) =>
    GoogleFonts.anton(color: color, fontSize: fontSize, letterSpacing: 1.5, height: 0.78);

// ─────────────────────────────────────────────────────────────
// COMPONENT THEMES
// ─────────────────────────────────────────────────────────────

// Default card = post / event / listing card: elevated surface + hairline border.
CardThemeData cardTheme(ColorScheme colors) => CardThemeData(
  elevation: 0,
  surfaceTintColor: Colors.transparent,
  color: colors.surfaceContainerLow,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
    side: BorderSide(color: colors.outlineVariant),
  ),
  margin: const EdgeInsets.symmetric(vertical: 6),
);

// Reusable decorations for the hand-built containers that aren't Cards
// (media tiles, event date blocks, stat pills, inline promos).

// Standard card surface — match cardTheme for Containers you build by hand.
BoxDecoration cardDecoration(ColorScheme colors) => BoxDecoration(
  color: colors.surfaceContainerLow,
  borderRadius: BorderRadius.circular(16),
  border: Border.all(color: colors.outlineVariant),
);

// Recessed block — date badges, avatars-on-dark, media placeholders.
BoxDecoration sunkenDecoration(ColorScheme colors) =>
    BoxDecoration(color: colors.surfaceContainerLowest, borderRadius: BorderRadius.circular(12));

// Highlight card — the terracotta-tinted "featured event / join" promo.
BoxDecoration signalDecoration(ColorScheme colors) => BoxDecoration(
  color: colors.tertiaryContainer,
  borderRadius: BorderRadius.circular(16),
  border: Border.all(color: colors.tertiary.withValues(alpha: 0.45)),
);

AppBarTheme appBarTheme(ColorScheme colors, bool isDark) => AppBarTheme(
  elevation: 0,
  scrolledUnderElevation: 0,
  backgroundColor: isDark ? colors.surface : colors.primary,
  foregroundColor: isDark ? colors.onSurface : colors.onPrimary,
  surfaceTintColor: Colors.transparent,
  centerTitle: false,
  titleTextStyle: GoogleFonts.oswald(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.8,
    color: isDark ? colors.onSurface : colors.onPrimary,
  ),
  systemOverlayStyle: const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ),
);

DialogThemeData dialogTheme(ColorScheme colors) => DialogThemeData(
  backgroundColor: colors.surfaceContainerLow,
  surfaceTintColor: Colors.transparent,
  elevation: 0,
  shape: shapeLarge,
);

// Bottom nav — deepest surface, olive selection pill, olive selected icon/label.
NavigationBarThemeData navigationBarTheme(ColorScheme colors) => NavigationBarThemeData(
  elevation: 0,
  backgroundColor: colors.surfaceContainerLowest,
  indicatorColor: colors.secondaryContainer,
  indicatorShape: const StadiumBorder(),
  iconTheme: WidgetStateProperty.resolveWith(
    (states) => states.contains(WidgetState.selected)
        ? IconThemeData(color: colors.onSecondaryContainer)
        : IconThemeData(color: colors.onSurfaceVariant),
  ),
  labelTextStyle: WidgetStateProperty.resolveWith(
    (states) => GoogleFonts.barlow(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: states.contains(WidgetState.selected) ? colors.secondary : colors.onSurfaceVariant,
    ),
  ),
);

// Filter / type / tag chips — olive when selected.
ChipThemeData chipTheme(ColorScheme colors) => ChipThemeData(
  backgroundColor: colors.surfaceContainer,
  selectedColor: colors.secondaryContainer,
  side: BorderSide(color: colors.outlineVariant),
  shape: const StadiumBorder(),
  showCheckmark: false,
  labelStyle: GoogleFonts.barlow(fontSize: 13, fontWeight: FontWeight.w600, color: colors.onSurfaceVariant),
  secondaryLabelStyle: GoogleFonts.barlow(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: colors.onSecondaryContainer,
  ),
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
);

FloatingActionButtonThemeData floatingActionButtonTheme(ColorScheme colors) => FloatingActionButtonThemeData(
  backgroundColor: colors.tertiary,
  foregroundColor: colors.onTertiary,
  elevation: 0,
  highlightElevation: 0,
);

// Primary CTA — terracotta signal (Participar, Comprar, Publicar, Entrar…).
ElevatedButtonThemeData elevatedButtonTheme(ColorScheme colors) => ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: colors.tertiary,
    foregroundColor: colors.onTertiary,
    elevation: 0,
    shadowColor: Colors.transparent,
    minimumSize: const Size.fromHeight(52),
    shape: shapeMedium,
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    textStyle: GoogleFonts.barlow(fontWeight: FontWeight.w700, fontSize: 16, letterSpacing: 0.5),
  ),
);

// Secondary action — outlined (e.g. "Já tenho conta", "Cancelar").
OutlinedButtonThemeData outlinedButtonTheme(ColorScheme colors) => OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    foregroundColor: colors.onSurface,
    side: BorderSide(color: colors.outlineVariant),
    minimumSize: const Size.fromHeight(52),
    shape: shapeMedium,
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    textStyle: GoogleFonts.barlow(fontWeight: FontWeight.w600, fontSize: 16, letterSpacing: 0.5),
  ),
);

// Text / low-emphasis action — brand-tinted.
TextButtonThemeData textButtonTheme(ColorScheme colors) => TextButtonThemeData(
  style: TextButton.styleFrom(
    foregroundColor: colors.secondary,
    textStyle: GoogleFonts.barlow(fontWeight: FontWeight.w700, fontSize: 15, letterSpacing: 0.3),
  ),
);

InputDecorationTheme inputDecorationTheme(ColorScheme colors) => InputDecorationTheme(
  filled: true,
  fillColor: colors.surfaceContainer,
  hintStyle: GoogleFonts.barlow(fontWeight: FontWeight.w500, color: colors.onSurfaceVariant),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: colors.outlineVariant),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: colors.outlineVariant),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: colors.tertiary, width: 1.5),
  ),
);

// ─────────────────────────────────────────────────────────────
// THEME ASSEMBLY
// ─────────────────────────────────────────────────────────────
ThemeData light() => ThemeData.light().copyWith(
  scaffoldBackgroundColor: lightColorScheme.surface,
  colorScheme: lightColorScheme,
  textTheme: textTheme(lightColorScheme),
  appBarTheme: appBarTheme(lightColorScheme, false),
  cardTheme: cardTheme(lightColorScheme),
  chipTheme: chipTheme(lightColorScheme),
  dialogTheme: dialogTheme(lightColorScheme),
  navigationBarTheme: navigationBarTheme(lightColorScheme),
  floatingActionButtonTheme: floatingActionButtonTheme(lightColorScheme),
  elevatedButtonTheme: elevatedButtonTheme(lightColorScheme),
  outlinedButtonTheme: outlinedButtonTheme(lightColorScheme),
  textButtonTheme: textButtonTheme(lightColorScheme),
  inputDecorationTheme: inputDecorationTheme(lightColorScheme),
  dividerColor: lightColorScheme.outlineVariant,
  // Subtle olive ripple instead of the harsh white InkSparkle default.
  splashColor: lightColorScheme.secondary.withValues(alpha: 0.12),
  highlightColor: lightColorScheme.secondary.withValues(alpha: 0.06),
);

ThemeData dark() => ThemeData.dark().copyWith(
  scaffoldBackgroundColor: darkColorScheme.surface,
  colorScheme: darkColorScheme,
  textTheme: textTheme(darkColorScheme),
  appBarTheme: appBarTheme(darkColorScheme, true),
  cardTheme: cardTheme(darkColorScheme),
  chipTheme: chipTheme(darkColorScheme),
  dialogTheme: dialogTheme(darkColorScheme),
  navigationBarTheme: navigationBarTheme(darkColorScheme),
  floatingActionButtonTheme: floatingActionButtonTheme(darkColorScheme),
  elevatedButtonTheme: elevatedButtonTheme(darkColorScheme),
  outlinedButtonTheme: outlinedButtonTheme(darkColorScheme),
  textButtonTheme: textButtonTheme(darkColorScheme),
  inputDecorationTheme: inputDecorationTheme(darkColorScheme),
  dividerColor: darkColorScheme.outlineVariant,
  // Subtle olive ripple instead of the harsh white InkSparkle default.
  splashColor: darkColorScheme.secondary.withValues(alpha: 0.12),
  highlightColor: darkColorScheme.secondary.withValues(alpha: 0.06),
);
