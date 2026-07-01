// Flutter packages
import 'package:flutter/material.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// A single circular story bubble in the Home stories row. Purely presentational
/// — feed it a name/image and an onTap.
class StoryAvatar extends StatelessWidget {
  const StoryAvatar({required this.name, this.imageUrl, this.onTap, super.key});

  final String name;
  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: context.colorScheme.tertiary, width: 2),
              ),
              child: CircleAvatar(
                radius: 28,
                backgroundColor: context.colorScheme.surfaceContainerHighest,
                backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
                child: imageUrl == null
                    ? Icon(Icons.person, color: context.colorScheme.onSurfaceVariant)
                    : null,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
