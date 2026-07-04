// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Controllers
import '/core/controllers/auth_controller.dart';
// Widgets
import '/widgets/user_avatar.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Create Post — a calm composer with the post types up front. Static for now;
/// the action buttons and "Publicar" don't submit anything yet.
class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key});

  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  static const postTypes = ['AAR', 'Pergunta', 'À venda', 'Evento'];

  final textController = TextEditingController();

  int selectedType = 0;

  @override
  void dispose() {
    textController.dispose();

    super.dispose();
  }

  Widget buildAuthorRow(String name) {
    return Row(
      children: [
        UserAvatar(name: name, picture: ref.watch(authProvider).user?.picture, radius: 22),

        const SizedBox(width: 12),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: context.textTheme.titleSmall),

            const SizedBox(height: 4),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.public, size: 13, color: context.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 5),
                  Text('Público', style: context.textTheme.labelSmall),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildPostTypes() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var i = 0; i < postTypes.length; i++)
          ChoiceChip(
            label: Text(postTypes[i]),
            selected: selectedType == i,
            onSelected: (_) => setState(() => selectedType = i),
          ),
      ],
    );
  }

  Widget buildToolbar() {
    // Attachment actions — visual only for now.
    const icons = [
      Icons.image_outlined,
      Icons.photo_camera_outlined,
      Icons.location_on_outlined,
      Icons.bar_chart_rounded,
    ];

    return BottomAppBar(
      height: 60,
      color: context.colorScheme.surfaceContainerLowest,
      child: Row(
        children: [
          for (final icon in icons)
            IconButton(
              onPressed: () {},
              icon: Icon(icon, color: context.colorScheme.onSurfaceVariant),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = ref.watch(authProvider).user?.name ?? 'Operador';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Nova publicação'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: context.colorScheme.tertiary,
                foregroundColor: context.colorScheme.onTertiary,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                minimumSize: const Size(0, 38),
              ),
              child: const Text('Publicar'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        children: [
          buildAuthorRow(name),

          const SizedBox(height: 16),

          TextField(
            controller: textController,
            maxLines: 6,
            minLines: 4,
            decoration: InputDecoration(
              filled: false,
              border: InputBorder.none,
              hintText: 'Compartilhe um AAR, faça uma pergunta ou publique fotos do campo...',
              hintStyle: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onSurfaceVariant),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'TIPO DE PUBLICAÇÃO',
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              letterSpacing: 1.5,
            ),
          ),

          const SizedBox(height: 12),

          buildPostTypes(),
        ],
      ),
      bottomNavigationBar: buildToolbar(),
    );
  }
}
