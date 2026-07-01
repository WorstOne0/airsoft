// Flutter packages
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Router
import '/router/app_routes.dart';
// Widgets
import '/widgets/placeholder_scaffold.dart';
// Pages
import 'pages/events_page.dart';

final eventsRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.events,
    builder: (_, _) => const EventsPage(),
    routes: [
      GoRoute(
        path: 'detail',
        builder: (_, _) => const PlaceholderScaffold(
          title: 'Evento',
          icon: FontAwesomeIcons.calendarDays,
          showBack: true,
        ),
      ),
      GoRoute(
        path: 'create',
        builder: (_, _) => const PlaceholderScaffold(
          title: 'Criar Evento',
          icon: FontAwesomeIcons.calendarPlus,
          showBack: true,
        ),
      ),
    ],
  ),
];
