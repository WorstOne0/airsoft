// Flutter packages
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Circular user avatar — shows the player's [picture] when available, otherwise
/// falls back to their initials on the olive brand color. Used in the app bar
/// (tap → profile) and anywhere a compact user chip is needed.
class UserAvatar extends StatelessWidget {
  const UserAvatar({required this.name, this.picture, this.radius = 18, this.onTap, super.key});

  final String name;
  final String? picture;
  final double radius;
  final VoidCallback? onTap;

  String initials() {
    final parts = name.trim().split(RegExp(r'[\s_]+')).where((part) => part.isNotEmpty).toList();

    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();

    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final hasPicture = picture != null && picture!.isNotEmpty;

    final avatar = CircleAvatar(
      radius: radius,
      backgroundColor: context.colorScheme.secondaryContainer,
      foregroundImage: hasPicture ? CachedNetworkImageProvider(picture!) : null,
      child: hasPicture
          ? null
          : Text(
              initials(),
              style: context.textTheme.labelLarge?.copyWith(
                color: context.colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.w700,
              ),
            ),
    );

    if (onTap == null) return avatar;

    return InkResponse(onTap: onTap, radius: radius + 6, child: avatar);
  }
}
