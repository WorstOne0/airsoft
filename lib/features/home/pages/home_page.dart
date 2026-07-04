// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Widgets
import '/widgets/app_top_bar.dart';
// Feature widgets
import '/features/home/widgets/post_card.dart';
import '/features/home/widgets/event_promo_card.dart';

/// Home feed — filter chips (Para você / Seguindo / Local) over a scannable list
/// of posts with an inline event promo. Placeholder content until the feed API
/// exists.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  static const filters = ['Para você', 'Seguindo', 'Local'];

  int selectedFilter = 0;

  Widget buildFilters() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, index) => ChoiceChip(
          label: Text(filters[index]),
          selected: selectedFilter == index,
          onSelected: (_) => setState(() => selectedFilter = index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(),
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        children: [
          buildFilters(),

          const SizedBox(height: 8),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                PostCard(
                  author: 'Delta_Ryan',
                  unit: '3rd Recon',
                  meta: 'Zona 5 · há 2h',
                  body: 'Push pesado no objetivo norte hoje de manhã. Setup novo '
                      'aguentou firme. AAR completo em breve 🫡',
                  photos: 4,
                  likes: 48,
                  comments: 12,
                ),

                SizedBox(height: 12),

                EventPromoCard(
                  day: '12',
                  month: 'Jul',
                  title: 'Woodland Milsim',
                  subtitle: 'Bravo Field · 24 confirmados',
                ),

                SizedBox(height: 12),

                PostCard(
                  author: 'FEAR Airsoft Cascavel',
                  meta: 'há 2 horas',
                  body: 'Vagas abertas para o próximo domingo. Chama no direct.',
                  photos: 2,
                  likes: 120,
                  comments: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
