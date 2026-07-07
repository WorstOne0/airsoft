// Flutter packages
import 'package:go_router/go_router.dart';
// Router
import '/router/app_routes.dart';
// Pages
import 'pages/events_page.dart';
import 'pages/event_detail_page.dart';

/// Events tab (branch). The event detail is a top-level route (see
/// [eventDetailRoutes]) so it opens full-screen without the bottom bar.
final eventsRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.events,
    builder: (_, _) => const EventsPage(),
  ),
];

/// Full-screen (over the shell) — no bottom bar, like the host flow.
final eventDetailRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.eventDetail,
    builder: (_, _) => const EventDetailPage(),
  ),
];
