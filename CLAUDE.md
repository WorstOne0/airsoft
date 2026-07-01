# Airsoft Cascavel — Claude Code Reference

## Project

Flutter **social app for the Airsoft Cascavel community**: feed (posts + stories),
marketplace, events/games, friends (community) and player profiles. Version
1.0.0+1, SDK ^3.11.5.

> Early stage. The architecture and screens are scaffolded; most pages are
> placeholders and there is **no backend yet** — auth runs on a mock (see
> _Mock auth_ below).

---

## Architecture

Clean layered architecture with feature-based UI (mirrors the `mobile_wiki`
base project):

```
Services → Repositories → Controllers (Riverpod) → UI (Features)
```

1. **Services** (`lib/services/`) — Pure I/O. Dio, Secure Storage, Hive,
   notifications, firebase messaging, location.
2. **Repositories** (`lib/core/repositories/`) — Data access wrapping services.
3. **Controllers** (`lib/core/controllers/`) — Riverpod `StateNotifier` holding
   app-wide state.
4. **Features** (`lib/features/`) — UI modules: pages, widgets, feature routes.
5. **Shared** — `lib/styles/`, `lib/widgets/`, `lib/utils/`, `lib/router/`.

### Folder structure

```
lib/
├── main.dart
├── core/
│   ├── controllers/          # auth_controller.dart (StateNotifier)
│   ├── models/               # user/auth_user.dart
│   └── repositories/         # auth_repository.dart
├── features/
│   ├── authentication/       # splash, login, register, account_created
│   ├── home/                 # feed: stories + posts  (+ widgets/)
│   ├── marketplace/          # buy/sell gear
│   ├── events/               # games / events
│   ├── community/            # friends
│   ├── profile/
│   └── settings/
├── services/
│   ├── apis/api_provider.dart          # Dio + token interceptor + env baseUrl
│   ├── storage/secure_storage.dart     # flutter_secure_storage
│   ├── storage/hive_storage.dart       # hive_ce
│   ├── notification_service.dart       # local notifications  (unwired)
│   ├── firebase_messaging_service.dart # FCM                  (unwired)
│   └── location_service.dart           # geolocator + maps helpers
├── router/
│   ├── app_router.dart       # GoRouter + StatefulShellRoute (5-tab bottom nav)
│   ├── app_routes.dart       # route path constants
│   ├── app_shell.dart        # NavigationBar (Início/Market/Eventos/Comunidade/Perfil)
│   └── router_notifier.dart  # auth redirect guard
├── styles/
│   ├── app_style.dart        # theme entry point (AppStyle.light()/dark())
│   ├── style_config.dart     # ColorSchemes + component themes
│   └── style_utils.dart      # design tokens (AppStyle.utils)
├── widgets/                  # shared: app_logo, placeholder_scaffold, my_loading
└── utils/
    ├── extensions/           # context, string, date_time, double, list
    └── type_utils/           # betterParseInt/Double/Boolean
```

Each feature: `pages/`, optional `widgets/` + `controllers/`, and a
`{feature}_routes.dart` exporting a `List<RouteBase>`.

---

## State management — Riverpod

- State lives in `StateNotifier` controllers exposed as providers.
- State classes are `@immutable`, updated via `copyWith()`.
- **Pages are `ConsumerStatefulWidget`** by default (easier to wire Riverpod +
  local UI state). Use `ConsumerWidget` only for trivial static screens.
- Controller methods return `({bool success, String message})` records so the UI
  can give feedback without try/catch at the call site.

## Navigation — Go Router

- Paths are constants in `AppRoutes`. Never hardcode a path.
- Authenticated tabs live in a `StatefulShellRoute.indexedStack` (5 branches);
  detail/create screens are **child routes** of their tab so the bottom bar
  stays visible. Push with `context.push(AppRoutes.xxx)`.
- `router_notifier.dart` redirects unauthenticated users to `/login`.
- `appRouter` (global) is available for context-free navigation from services.

---

## Code conventions

### No private class members
Do **not** use the `_` prefix for class fields/methods (project convention from
the base app). Local variables inside functions are fine. State classes
(`_LoginPageState`) keep the `_` because Flutter's `createState` requires it, and
small private `_helper()` build methods are acceptable.

### Widgets, not nested private classes
Do **not** declare private widget classes (`class _FooCard`) below a page. Either:
- extract a reusable widget into `widgets/` (shared) or the feature's `widgets/`
  folder (e.g. `home/widgets/post_card.dart`), **or**
- use a small `Widget _buildFoo()` method inside the State.

### Spacing
Keep breathing room: blank line after guard clauses, between field groups, and
between logical steps in a method / list of widget children. See
`auth_controller.dart` and `login_page.dart` for the intended rhythm.

### Naming
| Thing            | Convention          | Example                |
| ---------------- | ------------------- | ---------------------- |
| Files            | `snake_case.dart`   | `auth_controller.dart` |
| Classes          | `PascalCase`        | `AuthController`       |
| Controllers      | suffix `Controller` | `AuthController`       |
| State classes    | suffix `State`      | `AuthState`            |
| Providers        | camelCase           | `authProvider`         |
| Repositories     | suffix `Repository` | `AuthRepository`       |
| Route constants  | `AppRoutes.name`    | `AppRoutes.home`       |
| Extensions       | suffix `Extension`  | `StringExtension`      |

### Imports
Absolute imports (`import '/core/...'`), grouped with comments
(`// Flutter packages`, `// Router`, `// Controllers`, `// Widgets`, `// Utils`).

### Icons
`font_awesome_flutter` v11 uses `FaIconData` (not `IconData`) and the `FaIcon`
widget — pass FA icons to `FaIcon(...)`, and type any icon param that receives an
FA icon as `FaIconData`.

---

## Styling

- Warm military earth palette anchored on two brand bases: `#746a52` (khaki) and
  `#453f2f` (dark brown), with a brass/leather tertiary for CTAs. Both light and
  dark schemes in `style_config.dart`.
- Typography: **Rajdhani** via `google_fonts` (fetched at runtime; falls back to
  default offline — this is why headless theme tests are avoided).
- Tokens (spacing, radii, accents, durations) via `AppStyle.utils`.
- `AppLogo` renders the stacked AIR/SOFT wordmark used in headers.

---

## Mock auth (no backend yet)

`auth_repository.dart` has `useMockAuth = true`. Login accepts:

```
operador@airsoft.com / 123456   →  logs in as "Gustavo Cieslak Mota"
```

Register returns the mock user too. Set `useMockAuth = false` and fill in the
real endpoints in `AuthRepository` + `ApiProvider` when the API is ready.

---

## Services readiness

`notification_service`, `firebase_messaging_service` and `location_service`
exist and compile but are **not wired in `main()`**. To enable:

1. Notifications: call `notificationProvider.notificationInitialization()` at
   startup.
2. Firebase: add `firebase_options.dart`, run `Firebase.initializeApp(...)`,
   then `firebaseMessagingProvider.firebaseInitialization()`.
3. Maps: configure the Google Maps API key in the Android/iOS native projects.

---

## Adding a feature

1. Create `lib/features/{feature}/` with `pages/` and `{feature}_routes.dart`.
2. Add controller (`lib/core/controllers/` or feature-scoped) + repository if it
   needs data access.
3. Export a `List<RouteBase>` and register it in `lib/router/app_router.dart`
   (a shell branch for a tab, or top-level for a full-screen flow). Add path
   constants to `AppRoutes`.
4. Shared widgets → `lib/widgets/`; feature-specific → the feature's `widgets/`.

---

## Verify

```bash
flutter pub get
flutter analyze   # expect: No issues found!
flutter test
flutter run
```

## Key packages

| Package                    | Purpose                       |
| -------------------------- | ----------------------------- |
| `flutter_riverpod`         | State management              |
| `go_router`                | Navigation (shell + tabs)     |
| `dio`                      | HTTP client                   |
| `hive_ce` / `hive_ce_flutter` | Local NoSQL cache          |
| `flutter_secure_storage`   | Encrypted token storage       |
| `firebase_core` / `firebase_messaging` | Push (unwired)    |
| `flutter_local_notifications` | Local notifications        |
| `google_maps_flutter` / `geolocator` / `permission_handler` | Maps & location |
| `google_fonts`             | Rajdhani typography           |
| `font_awesome_flutter`     | Icons                         |
| `flutter_dotenv`           | `.env` config                 |
| `intl` / `logger` / `uuid` | Utilities                     |
```
