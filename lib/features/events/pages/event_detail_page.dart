// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Styles
import '/styles/style_config.dart' show airsoftField;
// Utils
import '/utils/extensions/context_extensions.dart';

/// Event detail — moody hero, roster fill bar and a sticky "Participar do jogo"
/// CTA. Static placeholder content until the events API exists.
class EventDetailPage extends ConsumerStatefulWidget {
  const EventDetailPage({super.key});

  @override
  ConsumerState<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends ConsumerState<EventDetailPage> {
  static const filled = 24;
  static const capacity = 40;

  Widget buildHeader(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [airsoftField, context.colorScheme.surface],
        ),
      ),
      alignment: Alignment.center,
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.landscape_outlined,
              size: 56,
              color: context.colorScheme.onSurface.withValues(alpha: 0.12),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Material(
                color: Colors.black.withValues(alpha: 0.4),
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () => context.pop(),
                  customBorder: const CircleBorder(),
                  child: const SizedBox(
                    width: 42,
                    height: 42,
                    child: Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTag(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: context.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label.toUpperCase(),
        style: context.textTheme.labelSmall?.copyWith(
          color: context.colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget buildInfoBox(BuildContext context, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.colorScheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(value, style: context.textTheme.titleSmall),
          ],
        ),
      ),
    );
  }

  Widget buildRoster(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Escalação', style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const Spacer(),
              Text(
                '$filled / $capacity preenchidas',
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: filled / capacity,
              minHeight: 10,
              backgroundColor: context.colorScheme.surfaceContainerHighest,
              color: context.colorScheme.secondary,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            '${capacity - filled} vagas · fecha 11 Jul',
            style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTag(context, 'Milsim · Dia inteiro'),

          const SizedBox(height: 12),

          Text(
            'WOODLAND MILSIM OP',
            style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700, height: 1.05),
          ),

          const SizedBox(height: 6),

          Text.rich(
            TextSpan(
              text: 'Organizado por ',
              style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
              children: [
                TextSpan(
                  text: '3rd Recon Unit',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              buildInfoBox(context, 'Data', 'Sáb 12 Jul · 09:00'),
              const SizedBox(width: 12),
              buildInfoBox(context, 'Taxa', 'R\$25 · BB incl.'),
            ],
          ),

          const SizedBox(height: 16),

          buildRoster(context),

          const SizedBox(height: 20),

          Text(
            'Push de dois times por objetivos em 40 hectares de mata. Magazines FMG, '
            'limite de 1.14J, cronografagem na entrada. Respawn na base a cada 15 min...',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLowest,
        border: Border(top: BorderSide(color: context.colorScheme.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Taxa de entrada',
                  style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
                ),
                Text('R\$25', style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),

            const SizedBox(width: 16),

            Expanded(
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: context.colorScheme.tertiary,
                  foregroundColor: context.colorScheme.onTertiary,
                  minimumSize: const Size.fromHeight(52),
                ),
                child: const Text('Participar do jogo'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                buildHeader(context),
                buildContent(context),
              ],
            ),
          ),

          buildBottomBar(context),
        ],
      ),
    );
  }
}
