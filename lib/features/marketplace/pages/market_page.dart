// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Router
import '/router/app_routes.dart';
// Widgets
import '/widgets/app_logo.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Marketplace — players buy/sell gear (loadouts, replicas, accessories).
/// Grid + "Vender" flow are placeholders until the listings API lands.
class MarketPage extends ConsumerStatefulWidget {
  const MarketPage({super.key});

  @override
  ConsumerState<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends ConsumerState<MarketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppLogo(),
        actions: [
          TextButton(
            onPressed: () => context.push(AppRoutes.marketCreate),
            child: Text('Vender', style: TextStyle(color: context.colorScheme.onPrimary)),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Marketplace',
                style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 8),

              Text(
                'Anúncios de equipamentos aparecerão aqui.',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium,
              ),

              const SizedBox(height: 20),

              OutlinedButton.icon(
                onPressed: () => context.push(AppRoutes.marketMine),
                icon: const Icon(Icons.sell_outlined),
                label: const Text('Meus anúncios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
