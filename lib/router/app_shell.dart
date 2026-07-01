// Flutter packages
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

/// Persistent bottom-navigation shell for the authenticated tabs.
/// Each tab keeps its own navigation stack via [StatefulNavigationShell], so
/// pushing a detail/create screen keeps the bar visible.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const destinations = <NavigationDestination>[
    NavigationDestination(icon: FaIcon(FontAwesomeIcons.house), label: 'Início'),
    NavigationDestination(icon: FaIcon(FontAwesomeIcons.store), label: 'Market'),
    NavigationDestination(icon: FaIcon(FontAwesomeIcons.calendarDays), label: 'Eventos'),
    NavigationDestination(icon: FaIcon(FontAwesomeIcons.userGroup), label: 'Comunidade'),
    NavigationDestination(icon: FaIcon(FontAwesomeIcons.user), label: 'Perfil'),
  ];

  void goBranch(int index) => navigationShell.goBranch(
    index,
    // Tapping the active tab resets it to its root.
    initialLocation: index == navigationShell.currentIndex,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: goBranch,
        destinations: destinations,
      ),
    );
  }
}
