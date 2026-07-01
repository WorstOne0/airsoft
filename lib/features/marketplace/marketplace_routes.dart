// Flutter packages
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Router
import '/router/app_routes.dart';
// Widgets
import '/widgets/placeholder_scaffold.dart';
// Pages
import 'pages/market_page.dart';

final marketplaceRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.market,
    builder: (_, _) => const MarketPage(),
    routes: [
      GoRoute(
        path: 'item',
        builder: (_, _) =>
            const PlaceholderScaffold(title: 'Anúncio', icon: FontAwesomeIcons.tag, showBack: true),
      ),
      GoRoute(
        path: 'create',
        builder: (_, _) => const PlaceholderScaffold(
          title: 'Criar Venda',
          icon: FontAwesomeIcons.tag,
          showBack: true,
        ),
      ),
      GoRoute(
        path: 'mine',
        builder: (_, _) => const PlaceholderScaffold(
          title: 'Meus Anúncios',
          icon: FontAwesomeIcons.tag,
          showBack: true,
        ),
      ),
    ],
  ),
];
