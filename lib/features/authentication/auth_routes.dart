// Flutter packages
import 'package:go_router/go_router.dart';
// Router
import '/router/app_routes.dart';
// Pages
import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/account_created_page.dart';

final authRoutes = <RouteBase>[
  GoRoute(path: AppRoutes.splash, builder: (_, _) => const SplashPage()),
  GoRoute(path: AppRoutes.login, builder: (_, _) => const LoginPage()),
  GoRoute(path: AppRoutes.register, builder: (_, _) => const RegisterPage()),
  GoRoute(path: AppRoutes.accountCreated, builder: (_, _) => const AccountCreatedPage()),
];
