// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────
// COLOR SCHEMES
// Airsoft Cascavel — warm military earth tones.
// Anchored on two brand bases from the design:
//   • #746a52  khaki / taupe   (lighter base)
//   • #453f2f  dark brown      (darker base)
// Tertiary is a brass/leather accent used for CTAs
// (Participar, Comprar, Publicar…).
// ─────────────────────────────────────────────────────────────
const lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // Brand — dark brown primary
  primary: Color(0xff453f2f),
  surfaceTint: Color(0xff746a52),
  onPrimary: Color(0xfffdfbf3),
  primaryContainer: Color(0xff746a52),
  onPrimaryContainer: Color(0xfff6f1e2),

  // Secondary — khaki / taupe
  secondary: Color(0xff746a52),
  onSecondary: Color(0xfffdfbf3),
  secondaryContainer: Color(0xffe3dcc7),
  onSecondaryContainer: Color(0xff322e22),

  // Tertiary — brass / leather accent
  tertiary: Color(0xff8a5a2b),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xfff5d9bc),
  onTertiaryContainer: Color(0xff311a06),

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
  onPrimary: Color(0xff302a1c),
  primaryContainer: Color(0xff453f2f),
  onPrimaryContainer: Color(0xffece3cd),

  secondary: Color(0xffcfc5aa),
  onSecondary: Color(0xff353020),
  secondaryContainer: Color(0xff544d38),
  onSecondaryContainer: Color(0xffece3cd),

  tertiary: Color(0xffecb684),
  onTertiary: Color(0xff48280a),
  tertiaryContainer: Color(0xff653e1c),
  onTertiaryContainer: Color(0xfff5d9bc),

  error: Color(0xfff2b8b5),
  onError: Color(0xff601410),
  errorContainer: Color(0xff8c1d18),
  onErrorContainer: Color(0xfff9dedc),

  // Surfaces — dark brown, stepping up to #453f2f for elevated cards
  surface: Color(0xff16130d),
  onSurface: Color(0xffe6e1d3),
  onSurfaceVariant: Color(0xffcdc5b0),
  surfaceContainerLowest: Color(0xff100e09),
  surfaceContainerLow: Color(0xff1e1a13),
  surfaceContainer: Color(0xff2a251b),
  surfaceContainerHigh: Color(0xff453f2f),
  surfaceContainerHighest: Color(0xff514a38),
  surfaceDim: Color(0xff16130d),
  surfaceBright: Color(0xff3d382c),

  outline: Color(0xff989079),
  outlineVariant: Color(0xff4c4636),

  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffe6e1d3),
  inversePrimary: Color(0xff453f2f),
);

// ─────────────────────────────────────────────────────────────
// SHAPE
// ─────────────────────────────────────────────────────────────
ShapeBorder get shapeSmall => RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
ShapeBorder get shapeMedium => RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
ShapeBorder get shapeLarge => RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));

// ─────────────────────────────────────────────────────────────
// TEXT THEME — Rajdhani gives a technical/tactical feel.
// ─────────────────────────────────────────────────────────────
TextTheme textTheme(ColorScheme colors) =>
    GoogleFonts.rajdhaniTextTheme().apply(bodyColor: colors.onSurface, displayColor: colors.onSurface);

// ─────────────────────────────────────────────────────────────
// COMPONENT THEMES
// ─────────────────────────────────────────────────────────────
CardThemeData cardTheme(ColorScheme colors) => CardThemeData(
  elevation: 0,
  surfaceTintColor: Colors.transparent,
  color: colors.surfaceContainerLow,
  shape: shapeMedium,
);

AppBarTheme appBarTheme(ColorScheme colors, bool isDark) => AppBarTheme(
  elevation: 0,
  scrolledUnderElevation: 0,
  backgroundColor: isDark ? colors.surface : colors.primary,
  foregroundColor: isDark ? colors.onSurface : colors.onPrimary,
  surfaceTintColor: Colors.transparent,
  centerTitle: false,
  titleTextStyle: GoogleFonts.rajdhani(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    color: isDark ? colors.onSurface : colors.onPrimary,
  ),
  systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: isDark ? Brightness.light : Brightness.light,
  ),
);

DialogThemeData dialogTheme(ColorScheme colors) => DialogThemeData(
  backgroundColor: colors.surface,
  surfaceTintColor: Colors.transparent,
  elevation: 0,
  shape: shapeLarge,
);

NavigationBarThemeData navigationBarTheme(ColorScheme colors) => NavigationBarThemeData(
  elevation: 0,
  backgroundColor: colors.surfaceContainer,
  indicatorColor: colors.primaryContainer,
  labelTextStyle: WidgetStatePropertyAll(
    GoogleFonts.rajdhani(fontSize: 12, fontWeight: FontWeight.w600),
  ),
);

FloatingActionButtonThemeData floatingActionButtonTheme(ColorScheme colors) =>
    FloatingActionButtonThemeData(
      backgroundColor: colors.tertiary,
      foregroundColor: colors.onTertiary,
      elevation: 0,
      highlightElevation: 0,
    );

ElevatedButtonThemeData elevatedButtonTheme(ColorScheme colors) => ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: colors.primary,
    foregroundColor: colors.onPrimary,
    elevation: 0,
    shadowColor: Colors.transparent,
    minimumSize: const Size.fromHeight(52),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    textStyle: GoogleFonts.rajdhani(fontWeight: FontWeight.w700, fontSize: 16, letterSpacing: 0.5),
  ),
);

InputDecorationTheme inputDecorationTheme(ColorScheme colors) => InputDecorationTheme(
  filled: true,
  fillColor: colors.surfaceContainer,
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
    borderSide: BorderSide(color: colors.primary, width: 1.5),
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
  dialogTheme: dialogTheme(lightColorScheme),
  navigationBarTheme: navigationBarTheme(lightColorScheme),
  floatingActionButtonTheme: floatingActionButtonTheme(lightColorScheme),
  elevatedButtonTheme: elevatedButtonTheme(lightColorScheme),
  inputDecorationTheme: inputDecorationTheme(lightColorScheme),
  dividerColor: lightColorScheme.outlineVariant,
  splashFactory: InkSparkle.splashFactory,
);

ThemeData dark() => ThemeData.dark().copyWith(
  scaffoldBackgroundColor: darkColorScheme.surface,
  colorScheme: darkColorScheme,
  textTheme: textTheme(darkColorScheme),
  appBarTheme: appBarTheme(darkColorScheme, true),
  cardTheme: cardTheme(darkColorScheme),
  dialogTheme: dialogTheme(darkColorScheme),
  navigationBarTheme: navigationBarTheme(darkColorScheme),
  floatingActionButtonTheme: floatingActionButtonTheme(darkColorScheme),
  elevatedButtonTheme: elevatedButtonTheme(darkColorScheme),
  inputDecorationTheme: inputDecorationTheme(darkColorScheme),
  dividerColor: darkColorScheme.outlineVariant,
  splashFactory: InkSparkle.splashFactory,
);
