// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Router
import '/router/app_routes.dart';
// Widgets
import '/widgets/app_logo.dart';
// Feature widgets
import '/features/home/widgets/story_avatar.dart';
import '/features/home/widgets/post_card.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Home feed — Stories row + Postagens (posts). The core social screen from the
/// design. Content is placeholder until the feed API exists.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  void openCreateMenu() {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.post_add),
              title: const Text('Publicação'),
              onTap: () {
                sheetContext.pop();
                context.push(AppRoutes.createPost);
              },
            ),
            ListTile(
              leading: const Icon(Icons.auto_stories_outlined),
              title: const Text('Stories'),
              onTap: () {
                sheetContext.pop();
                context.push(AppRoutes.createStory);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppLogo(),
        actions: [
          IconButton(onPressed: openCreateMenu, icon: const Icon(Icons.add_circle_outline)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          _sectionTitle('Stories'),

          SizedBox(
            height: 104,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 6,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (_, index) => StoryAvatar(name: 'Operador $index'),
            ),
          ),

          const SizedBox(height: 8),

          _sectionTitle('Postagens'),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                PostCard(author: 'Phantoms Team', team: 'Há 5 minutos', likes: 325, comments: 53),
                SizedBox(height: 12),
                PostCard(author: 'FEAR Airsoft Cascavel', team: 'Há 2 horas', likes: 120, comments: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Text(
        text,
        style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}
