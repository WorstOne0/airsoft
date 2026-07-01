// Flutter packages
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Models
import '/core/models/user/auth_user.dart';
// Repositories
import '/core/repositories/auth_repository.dart';

/// App-wide authentication state. `user == null` means logged out.
@immutable
class AuthState {
  const AuthState({this.user});

  final AuthUser? user;

  AuthState copyWith({AuthUser? user}) => AuthState(user: user ?? this.user);
}

/// Owns the auth session lifecycle. Methods return a `(success, message)`
/// record so the UI can show feedback without try/catch at the call site.
class AuthController extends StateNotifier<AuthState> {
  AuthController({required this.ref, required this.repository}) : super(const AuthState());

  final Ref ref;
  final AuthRepository repository;

  /// Restores a session from a stored token (called from the splash screen).
  Future<bool> isLogged() async {
    try {
      if (!await repository.hasValidToken()) return false;

      final user = await repository.getSession();
      state = state.copyWith(user: user);

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<({bool success, String message})> login(String email, String password) async {
    try {
      final token = await repository.login(email, password);
      await repository.saveToken(token);

      final user = await repository.getSession();
      state = state.copyWith(user: user);

      return (success: true, message: '');
    } catch (error) {
      return (success: false, message: error.toString());
    }
  }

  Future<({bool success, String message})> register(String name, String email, String password) async {
    try {
      await repository.register(name, email, password);
      return login(email, password);
    } catch (error) {
      return (success: false, message: error.toString());
    }
  }

  Future<void> logout() async {
    state = const AuthState(); // clearUser via fresh state
    await repository.clearSession();
  }
}

final authProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(ref: ref, repository: ref.watch(authRepositoryProvider)),
);
