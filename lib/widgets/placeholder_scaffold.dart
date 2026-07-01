// Flutter packages
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// Temporary scaffold for screens that aren't built yet. Gives every route a
/// consistent, recognizable "coming soon" state during scaffolding. Replace
/// each usage with the real page as features land.
class PlaceholderScaffold extends StatelessWidget {
  const PlaceholderScaffold({
    required this.title,
    this.icon = FontAwesomeIcons.personRifle,
    this.showBack = false,
    super.key,
  });

  final String title;
  final FaIconData icon;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), automaticallyImplyLeading: showBack),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(icon, size: 44, color: context.colorScheme.outline),

            const SizedBox(height: 14),

            Text('$title — em construção', style: context.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
