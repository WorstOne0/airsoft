// Flutter packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Router
import 'app_bottom_nav.dart';

/// Persistent bottom-navigation shell for the authenticated tabs.
/// Each tab keeps its own navigation stack via [StatefulNavigationShell], so
/// pushing a detail/create screen keeps the bar visible.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void goBranch(int index) => navigationShell.goBranch(
    index,
    // Tapping the active tab resets it to its root.
    initialLocation: index == navigationShell.currentIndex,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNav(
        currentIndex: navigationShell.currentIndex,
        onSelected: goBranch,
      ),
    );
  }
}
