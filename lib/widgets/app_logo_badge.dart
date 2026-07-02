// Flutter packages
import 'package:flutter/material.dart';

/// The full AIRSOFT military crest (`assets/images/logo.png`) used on the
/// welcome / auth screens. For the small stacked "AIR / SOFT" wordmark used in
/// in-app headers, use `AppLogo` instead.
class AppLogoBadge extends StatelessWidget {
  const AppLogoBadge({this.size = 160, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.medium,
    );
  }
}
