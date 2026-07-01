// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Controllers
import '/core/controllers/auth_controller.dart';
// Other
import 'app_routes.dart';

/// Drives Go Router redirects from auth state.
///
/// Rebuilds the router whenever [authProvider] changes and guards private
/// routes: unauthenticated users are bounced to [AppRoutes.login].
class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this.ref) {
    ref.listen<AuthState>(authProvider, (_, _) => notifyListeners());
  }

  final Ref ref;

  static const publicRoutes = {AppRoutes.splash, AppRoutes.login, AppRoutes.register};

  String? redirect(BuildContext context, GoRouterState state) {
    final isLoggedIn = ref.read(authProvider).user != null;

    if (publicRoutes.contains(state.matchedLocation)) return null;
    if (!isLoggedIn) return AppRoutes.login;

    return null;
  }
}
