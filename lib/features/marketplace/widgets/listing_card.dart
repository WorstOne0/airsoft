// Flutter packages
import 'package:flutter/material.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Marketplace grid tile — image with a category tag, title, condition line and
/// price with a bookmark. Static placeholder content for now.
class ListingCard extends StatelessWidget {
  const ListingCard({
    required this.category,
    required this.title,
    required this.subtitle,
    required this.price,
    this.onTap,
    super.key,
  });

  final String category;
  final String title;
  final String subtitle;
  final String price;
  final VoidCallback? onTap;

  Widget buildImage(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: context.colorScheme.surfaceContainerHighest,
              child: Icon(Icons.image_outlined, size: 36, color: context.colorScheme.outline),
            ),
          ),

          Positioned(
            left: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: context.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                category.toUpperCase(),
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImage(context),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleSmall,
                  ),

                  const SizedBox(height: 2),

                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Text(
                        price,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.tertiary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const Spacer(),

                      Icon(Icons.bookmark_border, size: 18, color: context.colorScheme.onSurfaceVariant),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
