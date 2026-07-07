// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Router
import '/router/app_routes.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Game live — the published confirmation. Share and manage-roster CTAs.
/// Static placeholder; "Gerenciar escalação" returns to the events feed.
class GameLivePage extends ConsumerStatefulWidget {
  const GameLivePage({super.key});

  @override
  ConsumerState<GameLivePage> createState() => _GameLivePageState();
}

class _GameLivePageState extends ConsumerState<GameLivePage> {
  Widget buildCheck() {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(shape: BoxShape.circle, color: context.colorScheme.secondary),
      child: Icon(Icons.check, size: 64, color: context.colorScheme.onSecondary),
    );
  }

  Widget buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  'SÁB',
                  style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
                ),
                Text(
                  '12',
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.tertiary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'JUL',
                  style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Woodland Milsim OP', style: context.textTheme.titleSmall),
                const SizedBox(height: 2),
                Text(
                  'Bravo Field · 0 / 40 inscritos',
                  style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 32),

                      buildCheck(),

                      const SizedBox(height: 24),

                      Text(
                        'SEU JOGO\nESTÁ NO AR',
                        textAlign: TextAlign.center,
                        style: context.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700, height: 1.05),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        'Woodland Milsim OP já está no mural.\nSeu esquadrão será notificado.',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
                      ),

                      const SizedBox(height: 28),

                      buildSummaryCard(),
                    ],
                  ),
                ),
              ),

              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share, size: 18),
                label: const Text('Compartilhar com o esquadrão'),
                style: FilledButton.styleFrom(
                  backgroundColor: context.colorScheme.tertiary,
                  foregroundColor: context.colorScheme.onTertiary,
                  minimumSize: const Size.fromHeight(54),
                ),
              ),

              const SizedBox(height: 12),

              OutlinedButton(
                onPressed: () => context.go(AppRoutes.events),
                style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(54)),
                child: const Text('Gerenciar escalação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
