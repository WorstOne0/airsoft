// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Router
import '/router/app_routes.dart';
// Feature widgets
import '/features/events/widgets/event_card.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Events — upcoming games ("Próximos") the player can join or host. Date-block
/// cards with going counts and type tags. Placeholder content for now.
class EventsPage extends ConsumerStatefulWidget {
  const EventsPage({super.key});

  @override
  ConsumerState<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends ConsumerState<EventsPage> {
  static const filters = ['Próximos', 'Organizando', 'Passados'];

  int selectedFilter = 0;

  Widget buildFilters() {
    return Wrap(
      spacing: 8,
      children: [
        for (var i = 0; i < filters.length; i++)
          ChoiceChip(
            label: Text(filters[i]),
            selected: selectedFilter == i,
            onSelected: (_) => setState(() => selectedFilter = i),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.tune), tooltip: 'Filtrar')],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.hostGame),
        icon: const Icon(Icons.add),
        label: const Text('Organizar'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        children: [
          buildFilters(),

          const SizedBox(height: 16),

          Row(
            children: [
              Text(
                '3 JOGOS PERTO DA ZONA 5',
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  letterSpacing: 1.2,
                ),
              ),

              const Spacer(),

              Text('Esta semana', style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.tertiary)),
            ],
          ),

          const SizedBox(height: 4),

          EventCard(
            weekday: 'Sáb',
            day: '12',
            month: 'Jul',
            typeTag: 'Milsim',
            slotsTag: '16 vagas',
            title: 'Woodland Milsim OP',
            location: 'Bravo Field · 09:00 · 8 km',
            goingCount: 24,
            onTap: () => context.push(AppRoutes.eventDetail),
            onJoin: () {},
          ),

          EventCard(
            weekday: 'Sex',
            day: '18',
            month: 'Jul',
            typeTag: 'CQB · Noite',
            title: 'Night Ops CQB',
            location: 'The Warehouse · 20:00 · 3 km',
            goingCount: 11,
            showBell: true,
            onTap: () => context.push(AppRoutes.eventDetail),
            onJoin: () {},
          ),
        ],
      ),
    );
  }
}
