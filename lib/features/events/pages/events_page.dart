// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
// Router
import '/router/app_routes.dart';
// Widgets
import '/widgets/app_top_bar.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Events — upcoming games ("Próximos Eventos") the player can join or create.
/// This is a core feature; the listing is a placeholder for now.
class EventsPage extends ConsumerStatefulWidget {
  const EventsPage({super.key});

  @override
  ConsumerState<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends ConsumerState<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        actions: [
          TextButton(
            onPressed: () => context.push(AppRoutes.eventCreate),
            child: Text('Criar', style: TextStyle(color: context.colorScheme.onPrimary)),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(FontAwesomeIcons.calendarDays, size: 44, color: context.colorScheme.outline),

            const SizedBox(height: 14),

            Text('Nenhum evento agendado.', style: context.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
