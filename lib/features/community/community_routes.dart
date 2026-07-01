// Flutter packages
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Router
import '/router/app_routes.dart';
// Widgets
import '/widgets/placeholder_scaffold.dart';
// Pages
import 'pages/community_page.dart';

final communityRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.community,
    builder: (_, _) => const CommunityPage(),
    routes: [
      GoRoute(
        path: 'add',
        builder: (_, _) => const PlaceholderScaffold(
          title: 'Adicionar Amigo',
          icon: FontAwesomeIcons.userPlus,
          showBack: true,
        ),
      ),
      GoRoute(
        path: 'friend',
        builder: (_, _) => const PlaceholderScaffold(
          title: 'Perfil do Amigo',
          icon: FontAwesomeIcons.user,
          showBack: true,
        ),
      ),
    ],
  ),
];
