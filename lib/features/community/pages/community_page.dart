// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
// Router
import '/router/app_routes.dart';
// Widgets
import '/widgets/app_logo.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Community — friends list and player discovery. Placeholder for now.
class CommunityPage extends ConsumerStatefulWidget {
  const CommunityPage({super.key});

  @override
  ConsumerState<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends ConsumerState<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppLogo(),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.friendAdd),
            icon: const Icon(Icons.person_add_alt),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(FontAwesomeIcons.userGroup, size: 44, color: context.colorScheme.outline),

            const SizedBox(height: 14),

            Text('Seus amigos aparecerão aqui.', style: context.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
