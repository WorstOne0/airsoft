// Flutter packages
import 'package:flutter/material.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Labeled text field used across the auth screens — an uppercase caption above
/// a themed [TextField], with an optional [footer] (e.g. a "codinome disponível"
/// hint). Keeps the login / register forms flat instead of repeating the
/// label + field boilerplate.
class AuthField extends StatelessWidget {
  const AuthField({
    required this.controller,
    required this.label,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.autocorrect = true,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.footer,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool autocorrect;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 2),
          child: Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              letterSpacing: 0.8,
            ),
          ),
        ),

        TextField(
          controller: controller,
          obscureText: obscureText,
          autocorrect: autocorrect,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: suffixIcon,
          ),
        ),

        if (footer != null) ...[
          const SizedBox(height: 6),
          footer!,
        ],
      ],
    );
  }
}
