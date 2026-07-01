// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Router
import '/router/app_routes.dart';
// Controllers
import '/core/controllers/auth_controller.dart';
// Widgets
import '/widgets/app_logo.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Player profile — avatar, team, post/friend counts and account actions.
/// Photo grid and friends are placeholders until those APIs exist.
class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  Future<void> handleLogout() async {
    await ref.read(authProvider.notifier).logout();
    if (mounted) context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).user;

    return Scaffold(
      appBar: AppBar(
        title: const AppLogo(),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.profileEdit),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () => context.push(AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: context.colorScheme.primaryContainer,
                  child: Text(
                    (user?.name.isNotEmpty ?? false) ? user!.name[0].toUpperCase() : '?',
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  user?.name ?? 'Operador',
                  style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),

                if (user?.team != null)
                  Text('Membro ${user!.team}', style: context.textTheme.bodyMedium),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _counter('Postagens', '0'),
              _counter('Amigos', '0'),
            ],
          ),

          const SizedBox(height: 32),

          OutlinedButton.icon(
            onPressed: handleLogout,
            icon: const Icon(Icons.logout),
            label: const Text('Sair'),
          ),
        ],
      ),
    );
  }

  Widget _counter(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        Text(label, style: context.textTheme.bodyMedium),
      ],
    );
  }
}
