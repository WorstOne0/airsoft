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
import '/utils/extensions/string_extensions.dart';

/// Account creation form (Nome, CPF, WhatsApp, Email, Cidade, Senha…).
/// Only name/email/password are sent to [AuthController] for now — extra fields
/// are collected and ready to wire to the backend when it exists.
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final whatsappController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    cpfController.dispose();
    whatsappController.dispose();
    emailController.dispose();
    cityController.dispose();
    passwordController.dispose();
    confirmController.dispose();

    super.dispose();
  }

  ({bool valid, String message}) validate() {
    if (nameController.text.trim().isEmpty) return (valid: false, message: 'Informe seu nome completo.');
    if (!emailController.text.trim().isEmail) return (valid: false, message: 'Informe um e-mail válido.');
    if (passwordController.text.length < 6) return (valid: false, message: 'A senha deve ter ao menos 6 caracteres.');
    if (passwordController.text != confirmController.text) return (valid: false, message: 'As senhas não coincidem.');

    return (valid: true, message: '');
  }

  Future<void> handleRegister() async {
    if (isLoading) return;

    final check = validate();
    if (!check.valid) {
      return context.showSnackBar(check.message, color: context.colorScheme.error);
    }

    setState(() => isLoading = true);

    final res = await ref.read(authProvider.notifier).register(
          nameController.text.trim(),
          emailController.text.trim(),
          passwordController.text,
        );

    if (!mounted) return;

    if (res.success) return context.go(AppRoutes.accountCreated);

    setState(() => isLoading = false);

    context.showSnackBar(
      res.message.isEmpty ? 'Não foi possível cadastrar.' : res.message,
      color: context.colorScheme.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: AppLogo(color: context.colorScheme.onSurface, fontSize: 44)),

              const SizedBox(height: 24),

              _field(nameController, 'Nome Completo'),
              _field(cpfController, 'CPF', keyboard: TextInputType.number),
              _field(whatsappController, 'WhatsApp', keyboard: TextInputType.phone),
              _field(emailController, 'Email', keyboard: TextInputType.emailAddress),
              _field(cityController, 'Cidade'),
              _field(passwordController, 'Senha', obscure: true),
              _field(confirmController, 'Confirmar Senha', obscure: true),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: isLoading ? null : handleRegister,
                child: isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                      )
                    : const Text('REGISTRAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    bool obscure = false,
    TextInputType? keyboard,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboard,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
