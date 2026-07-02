// Flutter packages
import 'package:flutter/material.dart';

/// Dark "camo bokeh" backdrop for the auth screens: a dark olive canvas with a
/// few small, blurred warm/olive light blobs near the top, fading to a single
/// solid color below [solidStart] (0–1 of the height) so copy reads cleanly.
class AuthBackground extends StatelessWidget {
  const AuthBackground({this.solidStart = 0.5, super.key});

  /// Fraction of the height at which the backdrop becomes fully solid.
  final double solidStart;

  static const _solid = Color(0xFF14160D);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const CustomPaint(painter: _CamoPainter()),

        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: const [Colors.transparent, _solid, _solid],
              stops: [0.0, solidStart, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}

/// Small, out-of-focus light blobs weighted toward the top of the canvas
/// (anything lower is hidden by the solid scrim anyway).
class _CamoPainter extends CustomPainter {
  const _CamoPainter();

  // [fractional x, y, radius (fraction of width), color]
  static const blobs = <(double, double, double, Color)>[
    (0.16, 0.09, 0.15, Color(0xFF6B5D3A)), // warm tan, top-left
    (0.85, 0.07, 0.13, Color(0xFF2C2E1C)), // dark olive, top-right
    (0.90, 0.26, 0.12, Color(0xFF8A7A4A)), // brass, upper-right
    (0.11, 0.30, 0.11, Color(0xFF4D4A2B)), // olive, upper-left
    (0.55, 0.15, 0.09, Color(0xFF7C6E42)), // small brass highlight
    (0.46, 0.36, 0.10, Color(0xFF23261A)), // deep shadow, center
  ];

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = const Color(0xFF181A10));

    final blur = MaskFilter.blur(BlurStyle.normal, size.width * 0.05);

    for (final (fx, fy, fr, color) in blobs) {
      final paint = Paint()
        ..color = color
        ..maskFilter = blur;

      canvas.drawCircle(Offset(fx * size.width, fy * size.height), fr * size.width, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
