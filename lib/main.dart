// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
// Router
import 'router/app_router.dart';
// Services
import 'services/storage/hive_storage.dart';
// Styles
import 'styles/app_style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Environment variables (.env) — optional in early development.
  await dotenv.load(fileName: '.env').catchError((_) {});

  // Local database
  await Hive.initFlutter();
  await Hive.openLazyBox(appBoxName);

  runApp(const ProviderScope(child: AirsoftCascavelApp()));
}

class AirsoftCascavelApp extends ConsumerWidget {
  const AirsoftCascavelApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Airsoft Cascavel',
      debugShowCheckedModeBanner: false,
      theme: AppStyle.light(),
      darkTheme: AppStyle.dark(),
      themeMode: ThemeMode.system,
      routerConfig: ref.watch(routerProvider),
      // pt-BR locale for dates/formatting.
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
    );
  }
}
