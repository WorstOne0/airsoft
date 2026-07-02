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

/// Entry screen. Attempts a silent session restore, then routes to Home or
/// Login. Keep any heavy startup work off this screen — it should be fast.
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => bootstrap());
  }

  Future<void> bootstrap() async {
    final logged = await ref.read(authProvider.notifier).isLogged();
    if (!mounted) return;
    context.go(logged ? AppRoutes.home : AppRoutes.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppLogo(color: context.colorScheme.onPrimary, fontSize: 64),

            const SizedBox(height: 8),

            Text(
              'CASCAVEL',
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.onPrimary,
                letterSpacing: 6,
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: 26,
              height: 26,
              child: CircularProgressIndicator(strokeWidth: 2.5, color: context.colorScheme.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
