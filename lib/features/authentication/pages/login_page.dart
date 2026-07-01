// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Router
import '/router/app_routes.dart';
// Controllers
import '/core/controllers/auth_controller.dart';
// Repositories
import '/core/repositories/auth_repository.dart' show mockEmail, mockPassword;
// Widgets
import '/widgets/app_logo.dart';
// Utils
import '/utils/extensions/context_extensions.dart';
import '/utils/extensions/string_extensions.dart';

/// Email/password login. Wired to [AuthController], which currently runs on a
/// mock backend — see [mockEmail] / [mockPassword] for the test credentials.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Future<void> handleLogin() async {
    if (isLoading) return;

    final email = emailController.text.trim();

    if (!email.isEmail) {
      return context.showSnackBar('Informe um e-mail válido.', color: context.colorScheme.error);
    }

    if (passwordController.text.isEmpty) {
      return context.showSnackBar('Informe sua senha.', color: context.colorScheme.error);
    }

    setState(() => isLoading = true);

    final res = await ref.read(authProvider.notifier).login(email, passwordController.text);
    if (!mounted) return;

    if (res.success) return context.go(AppRoutes.home);

    setState(() => isLoading = false);

    context.showSnackBar(
      res.message.isEmpty ? 'Não foi possível entrar.' : res.message,
      color: context.colorScheme.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: AppLogo(color: context.colorScheme.onSurface, fontSize: 56)),

                const SizedBox(height: 8),

                Center(
                  child: Text('Login', style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                ),

                const SizedBox(height: 32),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
                ),

                const SizedBox(height: 14),

                TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  onSubmitted: (_) => handleLogin(),
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: isLoading ? null : handleLogin,
                  child: isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                        )
                      : const Text('ENTRAR'),
                ),

                const SizedBox(height: 12),

                TextButton(
                  onPressed: () => context.showSnackBar('Recuperação de senha em breve.'),
                  child: const Text('Esqueceu a senha? Clique aqui'),
                ),

                const SizedBox(height: 8),

                const Divider(),

                const SizedBox(height: 8),

                Text('Ainda não possui uma conta?', textAlign: TextAlign.center, style: context.textTheme.bodyMedium),

                const SizedBox(height: 8),

                OutlinedButton(onPressed: () => context.push(AppRoutes.register), child: const Text('CADASTRAR')),

                const SizedBox(height: 24),

                // Dev helper — remove once the real backend is connected.
                Text(
                  'Login de teste: $mockEmail / $mockPassword',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.outline),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
