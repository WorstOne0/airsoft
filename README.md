# Airsoft Cascavel 🎯

Rede social mobile para a comunidade de **Airsoft Cascavel**. Reúne num só lugar:
**feed** (postagens + stories), **marketplace** (compra/venda de equipamentos),
**eventos/jogos**, **comunidade** (amigos) e **perfil** do operador.

> ⚠️ **Status:** projeto em fase inicial. Este repositório contém a
> **base / esqueleto** da arquitetura. A maioria das telas são _placeholders_ e
> ainda **não** há back-end conectado — a autenticação roda em **modo mock**
> (veja abaixo).

---

## O que dá pra fazer hoje

- Rodar o app e navegar pelo fluxo: **Splash → Login → App** com barra de
  navegação de 5 abas (**Início / Market / Eventos / Comunidade / Perfil**).
- **Entrar com o usuário mock** (login funcional sem back-end):

  ```
  Email:  operador@airsoft.com
  Senha:  123456
  ```

- Ver o feed (stories + postagens), cadastro, perfil e o tema militar
  (khaki `#746a52` / marrom `#453f2f`) em light e dark mode.
- Usar a base já plugada: estado (Riverpod), navegação (Go Router),
  armazenamento seguro/local (Secure Storage + Hive) e HTTP (Dio).

## O que ainda **não** existe

- Back-end real (as chamadas de API são placeholders; auth é mock).
- CRUD de postagens, stories, anúncios, eventos, amigos.
- Notificações push ativas (serviços prontos, porém não inicializados).
- Testes além de um smoke test de rotas.

---

## Arquitetura

Arquitetura em camadas com UI organizada por _feature_ — mesmo padrão do app
base da Wikidados:

```
Services → Repositories → Controllers (Riverpod) → UI (Features)
```

- **Services** (`lib/services/`) — I/O puro: Dio, Secure Storage, Hive.
- **Repositories** (`lib/core/repositories/`) — abstração de acesso a dados.
- **Controllers** (`lib/core/controllers/`) — `StateNotifier` (Riverpod) que
  detém o estado do app.
- **Features** (`lib/features/`) — módulos de UI (páginas, widgets e rotas).
- **Shared** — `lib/styles/`, `lib/widgets/`, `lib/utils/`, `lib/router/`.

### Estrutura de pastas

```
lib/
├── main.dart                     # bootstrap: dotenv, Hive, ProviderScope
├── core/
│   ├── controllers/              # auth_controller.dart (StateNotifier)
│   ├── models/                   # user/auth_user.dart
│   └── repositories/             # auth_repository.dart (mock auth)
├── features/
│   ├── authentication/           # splash, login, register, account_created
│   ├── home/                     # feed: stories + postagens (+ widgets/)
│   ├── marketplace/              # compra/venda de equipamentos
│   ├── events/                   # jogos / eventos
│   ├── community/                # amigos
│   ├── profile/
│   └── settings/
├── services/
│   ├── apis/api_provider.dart    # Dio + interceptors + baseUrl por ambiente
│   ├── storage/                  # secure_storage (tokens) + hive_storage
│   ├── notification_service.dart # notificações locais   (pronto, não plugado)
│   ├── firebase_messaging_service.dart # FCM             (pronto, não plugado)
│   └── location_service.dart     # geolocator + helpers de mapa
├── router/
│   ├── app_router.dart           # GoRouter + StatefulShellRoute (5 abas)
│   ├── app_routes.dart           # constantes de rota
│   ├── app_shell.dart            # NavigationBar persistente
│   └── router_notifier.dart      # redirecionamento por auth
├── styles/
│   ├── app_style.dart            # ponto de entrada do tema
│   ├── style_config.dart         # ColorSchemes + component themes
│   └── style_utils.dart          # tokens (espaçamento, raios, acentos)
├── widgets/                      # compartilhados: app_logo, placeholder_scaffold…
└── utils/
    ├── extensions/               # context, string, date_time, double, list
    └── type_utils/               # betterParseInt/Double/Boolean
```

Cada _feature_ segue o layout:

```
features/{feature}/
├── pages/
├── widgets/            (opcional)
├── controllers/        (opcional, escopo da feature)
└── {feature}_routes.dart
```

---

## Pacotes principais

| Pacote                    | Uso                                    |
| ------------------------- | -------------------------------------- |
| `flutter_riverpod`        | Gerência de estado                     |
| `go_router`               | Navegação (shell com bottom nav)       |
| `dio`                     | Cliente HTTP com interceptors          |
| `hive_ce` / `hive_ce_flutter` | Banco local NoSQL                  |
| `flutter_secure_storage`  | Armazenamento criptografado (tokens)   |
| `flutter_dotenv`          | Variáveis de ambiente (`.env`)         |
| `google_fonts`            | Tipografia (Rajdhani)                  |
| `font_awesome_flutter`    | Ícones                                 |
| `intl`                    | Formatação/localização (pt-BR)         |
| `logger` / `uuid`         | Utilitários                            |

---

## Convenções de código

- **Sem `_` privado** em membros de classe — campos e métodos são públicos
  (padrão herdado do projeto base).
- Estado imutável marcado com `@immutable`, atualizado via `copyWith()`.
- Controllers retornam `({bool success, String message})` para a UI dar
  feedback sem `try/catch` no call site.
- Imports absolutos (`import '/core/...'`) em vez de relativos.
- Nomes: arquivos `snake_case`, classes `PascalCase`, providers `camelCase`,
  controllers com sufixo `Controller`, repositórios `Repository`, widgets
  compartilhados com prefixo `My`.
- Rotas sempre por constante em `AppRoutes.*`.

## Como adicionar uma feature

1. Crie `lib/features/{feature}/` com `pages/` e `{feature}_routes.dart`.
2. Adicione controller (`lib/core/controllers/` ou dentro da feature).
3. Adicione repository em `lib/core/repositories/` se houver API.
4. Exporte a lista de rotas e registre em `lib/router/app_router.dart`.
5. Widgets compartilhados vão em `lib/widgets/`; específicos ficam na feature.

---

## Rodando o projeto

```bash
flutter pub get
flutter run
```

Configuração de ambiente em `.env` (URLs de API por ambiente). O arquivo é
opcional durante o desenvolvimento inicial — o app sobe mesmo sem ele.

### Verificação

```bash
flutter analyze   # deve reportar "No issues found!"
flutter test
```

---

## Próximos passos sugeridos

1. Conectar o back-end real e ajustar `AuthRepository` / `ApiProvider`.
2. Modelar `Event` (jogo) + repository/controller e a listagem em **Jogos**.
3. Fluxo de inscrição em jogos e histórico do operador.
4. Notificações (push) de novos jogos e avisos.
5. Aplicar o design final do Figma (cores/tipografia) em `styles/style_config.dart`.
