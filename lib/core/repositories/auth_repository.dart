// Flutter packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Models
import '/core/models/user/auth_user.dart';
// Services
import '/services/apis/api_provider.dart';
import '/services/storage/secure_storage.dart';

// ─────────────────────────────────────────────────────────────
// MOCK AUTH
// While there's no backend, login runs against these fake credentials and
// returns [mockUser]. Set [useMockAuth] to false once the API is connected.
// ─────────────────────────────────────────────────────────────
const useMockAuth = true;
const mockEmail = 'operador@airsoft.com';
const mockPassword = '123456';
const mockToken = 'mock-token';

const mockUser = AuthUser(
  id: 'mock-1',
  name: 'Gustavo Cieslak Mota',
  nickname: 'Gustavo',
  email: mockEmail,
  team: 'FEAR Airsoft Cascavel',
);

/// Data access for authentication. Wraps the API and secure token storage.
///
/// The network calls are placeholders wired to the expected shape of a REST
/// backend — adjust the endpoints/response parsing once the API exists.
class AuthRepository {
  const AuthRepository({required this.api, required this.storage});

  final ApiProvider api;
  final SecureStorage storage;

  static const tokenKey = 'authorizationToken';

  Future<bool> hasValidToken() async {
    final token = await storage.readString(tokenKey);
    return token != null && token.isNotEmpty;
  }

  /// Returns the auth token on success. Throws on failure.
  Future<String> login(String email, String password) async {
    if (useMockAuth) {
      await Future.delayed(const Duration(milliseconds: 600));

      if (email != mockEmail || password != mockPassword) {
        throw Exception('Usuário ou senha incorretos.');
      }

      return mockToken;
    }

    final res = await api.dio.post('/auth/login', data: {'email': email, 'password': password});
    return res.data['token'] as String;
  }

  Future<AuthUser> register(String name, String email, String password) async {
    if (useMockAuth) {
      await Future.delayed(const Duration(milliseconds: 600));
      return mockUser.copyWith(name: name);
    }

    final res = await api.dio.post(
      '/auth/register',
      data: {'name': name, 'email': email, 'password': password},
    );

    return AuthUser.fromJson(res.data['user'] as Map<String, dynamic>);
  }

  Future<AuthUser> getSession() async {
    if (useMockAuth) return mockUser;

    final res = await api.dio.get('/auth/session');
    return AuthUser.fromJson(res.data['user'] as Map<String, dynamic>);
  }

  Future<void> saveToken(String token) => storage.saveString(tokenKey, token);

  Future<void> clearSession() => storage.deleteKey(tokenKey);
}

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(api: ref.watch(apiProvider), storage: ref.watch(secureStorageProvider)),
);
