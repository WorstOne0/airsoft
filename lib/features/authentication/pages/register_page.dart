// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Router
import '/router/app_routes.dart';
// Controllers
import '/core/controllers/auth_controller.dart';
// Styles
import '/styles/app_style.dart';
// Widgets
import '/widgets/auth_field.dart';
// Utils
import '/utils/extensions/context_extensions.dart';
import '/utils/extensions/string_extensions.dart';

/// Minimal account creation — codinome (callsign), e-mail and senha. The
/// codinome is sent as the user's name to [AuthController]; the rest of the
/// operator profile (loadout, cidade, equipe…) is filled in later, in-app.
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final callsignController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false, isPasswordVisible = false, agreed = false;

  @override
  void initState() {
    super.initState();

    callsignController.addListener(refresh);
    passwordController.addListener(refresh);
  }

  @override
  void dispose() {
    callsignController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void refresh() => setState(() {});

  bool callsignAvailable() => callsignController.text.trim().length >= 3;

  /// 0 (empty) … 3 (strong). Mock heuristic — length + letter/number mix.
  int passwordStrength() {
    final password = passwordController.text;

    if (password.isEmpty) return 0;

    var strength = 1;

    if (password.length >= 6 && RegExp(r'[0-9]').hasMatch(password) && RegExp(r'[A-Za-z]').hasMatch(password)) {
      strength++;
    }

    if (password.length >= 10) strength++;

    return strength;
  }

  ({bool valid, String message}) validate() {
    if (!callsignAvailable()) return (valid: false, message: 'Escolha um codinome com ao menos 3 caracteres.');
    if (!emailController.text.trim().isEmail) return (valid: false, message: 'Informe um e-mail válido.');
    if (passwordController.text.length < 6) return (valid: false, message: 'A senha deve ter ao menos 6 caracteres.');
    if (!agreed) return (valid: false, message: 'É preciso aceitar as regras da comunidade.');

    return (valid: true, message: '');
  }

  Future<void> handleRegister() async {
    if (isLoading) return;

    final check = validate();
    if (!check.valid) {
      return context.showSnackBar(check.message, color: context.colorScheme.error);
    }

    setState(() => isLoading = true);

    final res = await ref
        .read(authProvider.notifier)
        .register(callsignController.text.trim(), emailController.text.trim(), passwordController.text);

    if (!mounted) return;

    if (res.success) return context.go(AppRoutes.accountCreated);

    setState(() => isLoading = false);

    context.showSnackBar(
      res.message.isEmpty ? 'Não foi possível cadastrar.' : res.message,
      color: context.colorScheme.error,
    );
  }

  Widget availableHint(Color color) {
    return Row(
      children: [
        Icon(Icons.check_circle, size: 14, color: color),

        const SizedBox(width: 6),

        Text('Codinome disponível', style: context.textTheme.labelSmall?.copyWith(color: color)),
      ],
    );
  }

  Widget createAgreement() {
    return InkWell(
      onTap: () => setState(() => agreed = !agreed),
      borderRadius: AppStyle.utils.borderRadiusSm,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: agreed,
              onChanged: (value) => setState(() => agreed = value ?? false),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text.rich(
                TextSpan(
                  text: 'Concordo com as ',
                  style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
                  children: [
                    TextSpan(
                      text: 'regras da comunidade',
                      style: TextStyle(color: context.colorScheme.onSurface, fontWeight: FontWeight.w700),
                    ),
                    const TextSpan(text: ' e o código de segurança.'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createStrengthMeter() {
    final strength = passwordStrength();

    final color = switch (strength) {
      >= 3 => AppStyle.utils.accentGreen,
      2 => context.colorScheme.secondary,
      _ => AppStyle.utils.accentAmber,
    };

    return Row(
      children: List.generate(3, (i) {
        final filled = i < strength;

        return Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.only(right: i < 2 ? 6 : 0),
            decoration: BoxDecoration(
              color: filled ? color : context.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final green = AppStyle.utils.accentGreen;

    return Scaffold(
      appBar: AppBar(title: const Text('CRIAR CONTA')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 12, 28, 28),
              // Fill at least the viewport (minus the 12+28 vertical padding) so the
              // Spacer can push the button block to the bottom; still scrolls when
              // the keyboard shrinks the available height.
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight - 40),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Configure seu perfil de operador — você pode detalhar seu loadout depois.',
                        style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
                      ),

                      const SizedBox(height: 28),

                      AuthField(
                        controller: callsignController,
                        label: 'CODINOME',
                        hintText: 'Delta_Ryan',
                        prefixIcon: Icons.person_outline,
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        suffixIcon: callsignAvailable() ? Icon(Icons.check, color: green) : null,
                        footer: callsignAvailable() ? availableHint(green) : null,
                      ),

                      const SizedBox(height: 18),

                      AuthField(
                        controller: emailController,
                        label: 'E-MAIL',
                        hintText: 'ryan@field.io',
                        prefixIcon: Icons.mail_outline,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                      ),

                      const SizedBox(height: 18),

                      AuthField(
                        controller: passwordController,
                        label: 'SENHA',
                        hintText: '••••••••',
                        prefixIcon: Icons.lock_outline,
                        obscureText: !isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                        ),
                        footer: createStrengthMeter(),
                      ),

                      const SizedBox(height: 20),

                      createAgreement(),

                      // Pushes the button block to the bottom when there's spare room.
                      const Spacer(),

                      const SizedBox(height: 24),

                      ElevatedButton(
                        onPressed: isLoading ? null : handleRegister,
                        child: switch (isLoading) {
                          true => const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                          ),
                          false => const Text('CRIAR CONTA'),
                        },
                      ),

                      const SizedBox(height: 20),

                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: 'Já é da tropa?',
                            style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: GestureDetector(
                                  onTap: () => context.canPop() ? context.pop() : context.go(AppRoutes.login),
                                  child: Text(
                                    'Entrar',
                                    style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
