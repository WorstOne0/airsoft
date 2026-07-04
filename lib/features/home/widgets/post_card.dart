// Flutter packages
import 'package:flutter/material.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Feed post card — author header with unit badge, body copy, a photo area and
/// a likes/comments/share footer. Static placeholder content for now; swap in a
/// Post model when the feed API lands.
class PostCard extends StatelessWidget {
  const PostCard({
    required this.author,
    required this.meta,
    this.unit,
    this.body,
    this.photos = 0,
    this.likes = 0,
    this.comments = 0,
    this.onTap,
    super.key,
  });

  final String author;
  final String meta;
  final String? unit;
  final String? body;
  final int photos;
  final int likes;
  final int comments;
  final VoidCallback? onTap;

  Widget buildUnitBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: context.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        unit!.toUpperCase(),
        style: context.textTheme.labelSmall?.copyWith(
          color: context.colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: context.colorScheme.surfaceContainerHighest,
              child: Icon(Icons.image_outlined, size: 44, color: context.colorScheme.outline),
            ),
          ),

          if (photos > 0)
            Positioned(
              left: 10,
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.photo_library_outlined, size: 14, color: Colors.white),
                    const SizedBox(width: 5),
                    Text(
                      '$photos fotos',
                      style: context.textTheme.labelSmall?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildFooter(BuildContext context) {
    final muted = context.colorScheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Icon(Icons.favorite_border, size: 18, color: context.colorScheme.tertiary),
          const SizedBox(width: 6),
          Text('$likes'),

          const SizedBox(width: 18),

          Icon(Icons.mode_comment_outlined, size: 18, color: muted),
          const SizedBox(width: 6),
          Text('$comments'),

          const SizedBox(width: 18),

          Icon(Icons.share_outlined, size: 18, color: muted),

          const Spacer(),

          Icon(Icons.bookmark_border, size: 18, color: muted),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: context.colorScheme.primaryContainer,
                child: Icon(Icons.person, color: context.colorScheme.onPrimaryContainer),
              ),
              title: Row(
                children: [
                  Flexible(child: Text(author, style: context.textTheme.titleSmall)),

                  if (unit != null) ...[
                    const SizedBox(width: 8),
                    buildUnitBadge(context),
                  ],
                ],
              ),
              subtitle: Text(meta),
              trailing: const Icon(Icons.more_horiz),
            ),

            if (body != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Text(body!, style: context.textTheme.bodyMedium),
              ),

            buildImage(context),

            buildFooter(context),
          ],
        ),
      ),
    );
  }
}
