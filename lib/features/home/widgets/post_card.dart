// Flutter packages
import 'package:flutter/material.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Feed post card — author header, image area, and a likes/comments footer.
/// Static placeholder content for now; swap in a Post model when the feed API
/// lands.
class PostCard extends StatelessWidget {
  const PostCard({
    required this.author,
    required this.team,
    this.likes = 0,
    this.comments = 0,
    this.onTap,
    super.key,
  });

  final String author;
  final String team;
  final int likes;
  final int comments;
  final VoidCallback? onTap;

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
              title: Text(author, style: context.textTheme.titleSmall),
              subtitle: Text(team),
              trailing: const Icon(Icons.more_horiz),
            ),

            AspectRatio(
              aspectRatio: 16 / 10,
              child: Container(
                color: context.colorScheme.surfaceContainerHighest,
                child: Icon(Icons.image_outlined, size: 48, color: context.colorScheme.outline),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.favorite_border, size: 18, color: context.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 6),
                  Text('$likes'),

                  const SizedBox(width: 18),

                  Icon(Icons.mode_comment_outlined, size: 18, color: context.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 6),
                  Text('$comments comentários'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
