// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Router
import '/router/app_routes.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Success confirmation shown after registration ("Conta Criada com Sucesso!").
class AccountCreatedPage extends ConsumerWidget {
  const AccountCreatedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_outline, size: 84, color: context.colorScheme.primary),

                const SizedBox(height: 20),

                Text(
                  'Conta Criada com Sucesso!',
                  textAlign: TextAlign.center,
                  style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                ),

                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => context.go(AppRoutes.home),
                    child: const Text('COMEÇAR'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
