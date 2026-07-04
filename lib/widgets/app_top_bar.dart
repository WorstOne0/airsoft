// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Router
import '/router/app_routes.dart';
// Controllers
import '/core/controllers/auth_controller.dart';
// Utils
import '/utils/extensions/context_extensions.dart';
// Widgets
import 'app_logo.dart';
import 'user_avatar.dart';

/// Shared app bar used across the authenticated tabs. Shows the stacked AIRSOFT
/// wordmark on the left and the logged-in player's avatar on the right (tap →
/// profile). Pass [actions] to render extra buttons just before the avatar.
class AppTopBar extends ConsumerWidget implements PreferredSizeWidget {
  const AppTopBar({this.actions, super.key});

  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;

    final logoColor = context.isDark ? context.colorScheme.onSurface : context.colorScheme.onPrimary;

    return AppBar(
      title: AppLogo(color: logoColor, fontSize: 18),
      titleSpacing: 16,
      actions: [
        ...?actions,

        Padding(
          padding: const EdgeInsets.only(right: 12, left: 4),
          child: UserAvatar(
            name: user?.name ?? 'Operador',
            picture: user?.picture,
            onTap: () => context.push(AppRoutes.profile),
          ),
        ),
      ],
    );
  }
}
