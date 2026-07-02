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
import '../widgets/auth_background.dart';
import '/widgets/app_logo_badge.dart';
import '/widgets/auth_field.dart';
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

  bool isLoading = false, isPasswordVisible = false;

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

  Widget orDivider() {
    final color = context.colorScheme.outlineVariant;

    return Row(
      children: [
        Expanded(child: Divider(color: color)),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OU',
            style: context.textTheme.labelMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
          ),
        ),

        Expanded(child: Divider(color: color)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: AuthBackground(solidStart: 0.30)),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),

                  Center(child: AppLogoBadge(size: context.screenWidth * 0.40)),

                  const SizedBox(height: 20),

                  Text(
                    'BEM-VINDO DE VOLTA',
                    style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Faça login para voltar à ação.',
                    style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
                  ),

                  const SizedBox(height: 28),

                  AuthField(
                    controller: emailController,
                    label: 'E-MAIL OU CODINOME',
                    hintText: 'operador@airsoft.com',
                    prefixIcon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                  ),

                  const SizedBox(height: 18),

                  AuthField(
                    controller: passwordController,
                    label: 'SENHA',
                    hintText: '••••••••',
                    prefixIcon: Icons.lock_outline,
                    obscureText: !isPasswordVisible,
                    onSubmitted: (_) => handleLogin(),
                    suffixIcon: IconButton(
                      icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.showSnackBar('Recuperação de senha em breve.'),
                      child: const Text('Esqueceu a senha?'),
                    ),
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton(
                    onPressed: isLoading ? null : handleLogin,
                    child: switch (isLoading) {
                      true => const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                      ),
                      false => const Text('ENTRAR'),
                    },
                  ),

                  const SizedBox(height: 20),

                  orDivider(),

                  const SizedBox(height: 20),

                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'Novo por aqui? ',
                        style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: GestureDetector(
                              onTap: () => context.push(AppRoutes.register),
                              child: Text(
                                'Criar conta',
                                style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

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
        ],
      ),
    );
  }
}
