// Flutter packages
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Router
import '/router/app_routes.dart';
// Widgets
import '/widgets/placeholder_scaffold.dart';
// Pages
import 'pages/profile_page.dart';

final profileRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.profile,
    builder: (_, _) => const ProfilePage(),
    routes: [
      GoRoute(
        path: 'edit',
        builder: (_, _) => const PlaceholderScaffold(
          title: 'Editar Perfil',
          icon: FontAwesomeIcons.userPen,
          showBack: true,
        ),
      ),
    ],
  ),
];
