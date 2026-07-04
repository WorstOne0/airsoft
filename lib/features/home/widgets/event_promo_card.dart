// Flutter packages
import 'package:flutter/material.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Inline event promo shown between feed posts — a date block, the event title
/// and field/going count, plus a "Participar" CTA. Placeholder content until the
/// events API lands.
class EventPromoCard extends StatelessWidget {
  const EventPromoCard({
    required this.day,
    required this.month,
    required this.title,
    required this.subtitle,
    this.onJoin,
    this.onTap,
    super.key,
  });

  final String day;
  final String month;
  final String title;
  final String subtitle;
  final VoidCallback? onJoin;
  final VoidCallback? onTap;

  Widget buildDateBlock(BuildContext context) {
    return Container(
      width: 52,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            day,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.tertiary,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            month.toUpperCase(),
            style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorScheme.secondaryContainer.withValues(alpha: 0.35),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              buildDateBlock(context),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 2),

                    Text(
                      subtitle,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              FilledButton(
                onPressed: onJoin,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, 40),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                ),
                child: const Text('Participar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
