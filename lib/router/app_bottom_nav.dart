// Flutter packages
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Utils
import '/utils/extensions/context_extensions.dart';

/// A single tab destination in [AppBottomNav].
class NavItem {
  const NavItem({required this.icon, required this.label, required this.branch});

  final FaIconData icon;
  final String label;

  /// Index of the matching [StatefulShellBranch] in the router.
  final int branch;
}

/// Bottom navigation bar for the authenticated shell — Início · Eventos ·
/// Market · Comunidade, with an olive selection pill. Profile is reached from
/// the app-bar avatar, not a tab.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({required this.currentIndex, required this.onSelected, super.key});

  final int currentIndex;
  final ValueChanged<int> onSelected;

  static const items = <NavItem>[
    NavItem(icon: FontAwesomeIcons.house, label: 'Início', branch: 0),
    NavItem(icon: FontAwesomeIcons.calendarDays, label: 'Eventos', branch: 1),
    NavItem(icon: FontAwesomeIcons.store, label: 'Market', branch: 2),
    NavItem(icon: FontAwesomeIcons.userGroup, label: 'Comunidade', branch: 3),
  ];

  Widget buildItem(BuildContext context, NavItem item) {
    final selected = item.branch == currentIndex;

    final color = selected ? context.colorScheme.onSecondaryContainer : context.colorScheme.onSurfaceVariant;

    return Expanded(
      child: InkResponse(
        onTap: () => onSelected(item.branch),
        radius: 40,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: selected ? context.colorScheme.secondaryContainer : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
              ),
              child: FaIcon(item.icon, size: 18, color: color),
            ),

            const SizedBox(height: 4),

            Text(
              item.label,
              style: context.textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 68,
      padding: EdgeInsets.zero,
      color: context.colorScheme.surfaceContainerLowest,
      child: Row(
        children: [for (final item in items) buildItem(context, item)],
      ),
    );
  }
}
