// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Router
import '/router/app_routes.dart';
// Feature widgets
import '/features/marketplace/widgets/listing_card.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Marketplace — players buy/sell gear. Search, category chips and a 2-column
/// grid of listings. Placeholder content until the listings API lands.
class MarketPage extends ConsumerStatefulWidget {
  const MarketPage({super.key});

  @override
  ConsumerState<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends ConsumerState<MarketPage> {
  static const categories = ['Todos', 'Réplicas', 'Equipamento', 'BBs'];

  static const listings = [
    (category: 'Réplicas', title: 'TM M4A1 MWS', subtitle: 'Usado · Bom · 4 km', price: 'R\$320'),
    (category: 'Equipamento', title: 'JPC Plate Carrier', subtitle: 'Ranger Green · 7 km', price: 'R\$85'),
    (category: 'Óptica', title: 'EOTech Repro', subtitle: 'Novo na caixa · 2 km', price: 'R\$45'),
    (category: 'BBs', title: '0.28g Bio ×5k', subtitle: 'Lacrado · 6 km', price: 'R\$18'),
  ];

  int selectedCategory = 0;

  Widget buildSearch() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Buscar equipamentos, réplicas...',
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }

  Widget buildCategories() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, index) => ChoiceChip(
          label: Text(categories[index]),
          selected: selectedCategory == index,
          onSelected: (_) => setState(() => selectedCategory = index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mercado')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.marketCreate),
        icon: const Icon(Icons.add),
        label: const Text('Vender'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        children: [
          buildSearch(),

          const SizedBox(height: 12),

          buildCategories(),

          const SizedBox(height: 16),

          Row(
            children: [
              Text(
                '124 ANÚNCIOS',
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  letterSpacing: 1.2,
                ),
              ),

              const Spacer(),

              Row(
                children: [
                  Icon(Icons.sort, size: 16, color: context.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 4),
                  Text('Mais perto', style: context.textTheme.labelSmall),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.62,
            children: [
              for (final item in listings)
                ListingCard(
                  category: item.category,
                  title: item.title,
                  subtitle: item.subtitle,
                  price: item.price,
                  onTap: () => context.push(AppRoutes.marketItem),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
