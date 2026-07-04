// Flutter packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Features
import '/features/authentication/auth_routes.dart';
import '/features/home/home_routes.dart';
import '/features/marketplace/marketplace_routes.dart';
import '/features/events/events_routes.dart';
import '/features/community/community_routes.dart';
import '/features/profile/profile_routes.dart';
import '/features/settings/settings_routes.dart';
// Router
import 'app_routes.dart';
import 'app_shell.dart';
import 'router_notifier.dart';

/// Global router instance — set once when [routerProvider] is first read.
/// Use for context-free navigation from services: `appRouter.go(...)`.
late final GoRouter appRouter;

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = RouterNotifier(ref);
  ref.onDispose(notifier.dispose);

  return appRouter = GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: [
      // Full-screen routes (no bottom bar)
      ...authRoutes,
      ...settingsRoutes,
      // Profile opens over the shell from the app-bar avatar (not a tab).
      ...profileRoutes,

      // Authenticated tabs wrapped in the persistent shell.
      // Branch order must match the indices in [AppBottomNav].
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: homeRoutes),
          StatefulShellBranch(routes: eventsRoutes),
          StatefulShellBranch(routes: marketplaceRoutes),
          StatefulShellBranch(routes: communityRoutes),
        ],
      ),
    ],
  );
});
