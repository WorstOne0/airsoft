// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Router
import '/router/app_routes.dart';
// Widgets
import '../widgets/auth_background.dart';
import '/widgets/app_logo_badge.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Unauthenticated entry point — a warm welcome carousel with a single clear
/// pair of CTAs (criar conta / já tenho conta). The camo hero stays dark like a
/// field photo regardless of the app theme; only the marketing copy swipes.
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final pageController = PageController();

  int index = 0;

  static const slides = <({String title, String subtitle})>[
    (
      title: 'ENCONTRE SEU\nPRÓXIMO JOGO',
      subtitle:
          'Publique relatos, organize partidas e negocie equipamento com a galera do airsoft da sua região — tudo em um só lugar.',
    ),
    (
      title: 'CONECTE-SE\nCOM A TROPA',
      subtitle: 'Adicione amigos, monte sua equipe e veja quem já confirmou presença no próximo domingo em campo.',
    ),
    (
      title: 'SEU ARSENAL,\nSEU PERFIL',
      subtitle: 'Monte seu perfil de operador, mostre seu loadout e sua patente para toda a comunidade.',
    ),
  ];

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  Widget slideText(({String title, String subtitle}) slide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          slide.title,
          style: context.textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            height: 1.05,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          slide.subtitle,
          style: context.textTheme.bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.72), height: 1.4),
        ),
      ],
    );
  }

  Widget dots() {
    return Row(
      children: List.generate(slides.length, (i) {
        final active = i == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          margin: const EdgeInsets.only(right: 6),
          width: active ? 22 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? context.colorScheme.tertiary : Colors.white.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff14160d),
      body: Stack(
        children: [
          const Positioned.fill(child: AuthBackground(solidStart: 0.5)),

          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(child: AppLogoBadge(size: context.screenWidth * 0.58)),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 150,
                        child: PageView.builder(
                          controller: pageController,
                          onPageChanged: (i) => setState(() => index = i),
                          itemCount: slides.length,
                          itemBuilder: (_, i) => slideText(slides[i]),
                        ),
                      ),

                      const SizedBox(height: 16),

                      dots(),

                      const SizedBox(height: 24),

                      ElevatedButton(
                        onPressed: () => context.push(AppRoutes.register),
                        child: const Text('CRIAR CONTA'),
                      ),

                      const SizedBox(height: 12),

                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Colors.white.withValues(alpha: 0.25)),
                        ),
                        onPressed: () => context.push(AppRoutes.login),
                        child: const Text('JÁ TENHO UMA CONTA'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
