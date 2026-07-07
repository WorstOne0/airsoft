// Flutter packages
import 'package:flutter/material.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Date-block event card for the Events feed — weekday/day badge, type + slots
/// tags, title, location line and a going count with a "Participar" CTA.
class EventCard extends StatelessWidget {
  const EventCard({
    required this.weekday,
    required this.day,
    required this.month,
    required this.typeTag,
    required this.title,
    required this.location,
    required this.goingCount,
    this.slotsTag,
    this.showBell = false,
    this.onTap,
    this.onJoin,
    super.key,
  });

  final String weekday;
  final String day;
  final String month;
  final String typeTag;
  final String title;
  final String location;
  final int goingCount;
  final String? slotsTag;
  final bool showBell;
  final VoidCallback? onTap;
  final VoidCallback? onJoin;

  Widget buildDateBlock(BuildContext context) {
    return Container(
      width: 64,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            weekday.toUpperCase(),
            style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
          ),
          Text(
            day,
            style: context.textTheme.headlineSmall?.copyWith(
              color: context.colorScheme.tertiary,
              fontWeight: FontWeight.w700,
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

  Widget buildTag(BuildContext context, String label, {bool signal = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: signal ? context.colorScheme.tertiaryContainer : context.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label.toUpperCase(),
        style: context.textTheme.labelSmall?.copyWith(
          color: signal ? context.colorScheme.onTertiaryContainer : context.colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget buildGoing(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 28,
      child: Stack(
        children: [
          for (var i = 0; i < 3; i++)
            Positioned(
              left: i * 16.0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: context.colorScheme.surfaceContainerLow, width: 2),
                ),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: context.colorScheme.secondaryContainer,
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
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDateBlock(context),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            buildTag(context, typeTag),

                            if (slotsTag != null) ...[
                              const SizedBox(width: 6),
                              buildTag(context, slotsTag!, signal: true),
                            ],
                          ],
                        ),

                        const SizedBox(height: 8),

                        Text(
                          title,
                          style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                        ),

                        const SizedBox(height: 4),

                        Row(
                          children: [
                            Icon(Icons.place_outlined, size: 14, color: context.colorScheme.onSurfaceVariant),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                location,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1, color: context.colorScheme.outlineVariant),
              ),

              Row(
                children: [
                  buildGoing(context),

                  const SizedBox(width: 8),

                  Text('$goingCount confirmados', style: context.textTheme.bodySmall),

                  const Spacer(),

                  if (showBell)
                    IconButton(
                      onPressed: () {},
                      visualDensity: VisualDensity.compact,
                      icon: Icon(Icons.notifications_none_rounded, color: context.colorScheme.onSurfaceVariant),
                    ),

                  FilledButton(
                    onPressed: onJoin,
                    style: FilledButton.styleFrom(
                      backgroundColor: context.colorScheme.tertiary,
                      foregroundColor: context.colorScheme.onTertiary,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      minimumSize: const Size(0, 38),
                    ),
                    child: const Text('Participar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
