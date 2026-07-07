// Flutter packages
import 'package:go_router/go_router.dart';
// Router
import '/router/app_routes.dart';
// Pages
import 'pages/host_game_page.dart';
import 'pages/game_live_page.dart';

/// The host-a-game flow — a single full-screen form pushed over the shell (no
/// bottom bar), then the published confirmation.
final hostRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.hostGame,
    builder: (_, _) => const HostGamePage(),
    routes: [
      GoRoute(
        path: 'published',
        builder: (_, _) => const GameLivePage(),
      ),
    ],
  ),
];
