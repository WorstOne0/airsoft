// Flutter packages
import 'package:flutter/material.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Centered progress indicator. Shared, reusable — prefix shared widgets with
/// `My` (e.g. `MyLoading`, `MyAppBar`) as a project convention.
class MyLoading extends StatelessWidget {
  const MyLoading({this.size = 28, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(strokeWidth: 2.5, color: context.colorScheme.primary),
      ),
    );
  }
}
