// Flutter packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
// Router
import '/router/app_router.dart';
import '/router/app_routes.dart';
// Styles
import '/styles/app_style.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Create menu presented from the shell FAB — pick a new post or a new story.
/// Built on `wolt_modal_sheet` so every modal in the app shares one bottom-sheet
/// presentation pattern. Call [CreateMenuSheet.show] to open it.
class CreateMenuSheet extends StatelessWidget {
  const CreateMenuSheet({super.key});

  static Future<void> show(BuildContext context) async {
    await WoltModalSheet.show(
      context: context,
      barrierDismissible: true,
      modalTypeBuilder: (_) => WoltModalType.bottomSheet(),
      onModalDismissedWithBarrierTap: () => Navigator.of(context).pop(),
      pageListBuilder: (modalSheetContext) => [
        WoltModalSheetPage(
          hasTopBarLayer: false,
          backgroundColor: modalSheetContext.colorScheme.surface,
          child: const CreateMenuSheet(),
        ),
      ],
    );
  }

  /// Close the sheet, then navigate. Uses the global [appRouter] so the push
  /// survives the modal context being torn down.
  void openRoute(BuildContext context, String route) {
    context.pop();
    appRouter.push(route);
  }

  Widget buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CRIAR',
          style: context.textTheme.labelSmall?.copyWith(
            color: AppStyle.utils.textSubtle(context),
            letterSpacing: 1.5,
          ),
        ),

        Text(
          'O que vamos publicar?',
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppStyle.utils.borderRadiusMd,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: context.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: context.colorScheme.onSecondaryContainer),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: context.textTheme.titleSmall),

                    const SizedBox(height: 2),

                    Text(
                      subtitle,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppStyle.utils.textMuted(context),
                      ),
                    ),
                  ],
                ),
              ),

              Icon(Icons.chevron_right, color: AppStyle.utils.textMuted(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCancelButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outlineVariant),
          borderRadius: AppStyle.utils.borderRadiusMd,
        ),
        child: Text(
          'Cancelar',
          style: context.textTheme.titleSmall?.copyWith(color: AppStyle.utils.textMuted(context)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(context),

            const SizedBox(height: 16),

            buildActionCard(
              context,
              icon: Icons.post_add,
              title: 'Publicação',
              subtitle: 'Compartilhe uma partida ou novidade',
              onTap: () => openRoute(context, AppRoutes.createPost),
            ),

            const SizedBox(height: 10),

            buildActionCard(
              context,
              icon: Icons.auto_stories_outlined,
              title: 'Stories',
              subtitle: 'Um momento rápido que some em 24h',
              onTap: () => openRoute(context, AppRoutes.createStory),
            ),

            const SizedBox(height: 16),

            buildCancelButton(context),
          ],
        ),
      ),
    );
  }
}
