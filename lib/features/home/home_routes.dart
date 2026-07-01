// Flutter packages
import 'package:go_router/go_router.dart';
// Router
import '/router/app_routes.dart';
// Widgets
import '/widgets/placeholder_scaffold.dart';
// Pages
import 'pages/home_page.dart';

final homeRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.home,
    builder: (_, _) => const HomePage(),
    routes: [
      GoRoute(
        path: 'create-post',
        builder: (_, _) => const PlaceholderScaffold(title: 'Criar Publicação', showBack: true),
      ),
      GoRoute(
        path: 'create-story',
        builder: (_, _) => const PlaceholderScaffold(title: 'Criar Stories', showBack: true),
      ),
      GoRoute(
        path: 'post',
        builder: (_, _) => const PlaceholderScaffold(title: 'Publicação', showBack: true),
      ),
    ],
  ),
];
