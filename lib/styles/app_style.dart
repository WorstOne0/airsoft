// Flutter packages
import 'package:flutter/material.dart';
// Other
import 'style_config.dart' as style_default;
import 'style_utils.dart';

/// Central access point for the app theme.
///
/// Add new [StyleVariant]s here and switch on them to support alternate
/// palettes (e.g. a high-contrast field theme) without touching call sites.
enum StyleVariant { defaultStyle }

class AppStyle {
  static StyleVariant variant = StyleVariant.defaultStyle;

  static const utils = StyleUtils();

  static ThemeData light() => switch (variant) {
    StyleVariant.defaultStyle => style_default.light(),
  };

  static ThemeData dark() => switch (variant) {
    StyleVariant.defaultStyle => style_default.dark(),
  };
}
