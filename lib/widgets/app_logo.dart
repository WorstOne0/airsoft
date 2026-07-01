// Flutter packages
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// The "AIRSOFT" wordmark used across headers. Stacks AIR / SOFT like the
/// design. Swap for an SVG/PNG logo asset once branding is finalized.
class AppLogo extends StatelessWidget {
  const AppLogo({this.color, this.fontSize = 20, super.key});

  final Color? color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final logoColor = color ?? context.colorScheme.onPrimary;

    final style = GoogleFonts.rajdhani(
      color: logoColor,
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      letterSpacing: 2,
      height: 0.95,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('AIR', style: style),
        Text('SOFT', style: style),
      ],
    );
  }
}
