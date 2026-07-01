// Dart
import 'dart:io';
// Flutter packages
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Services
import '/services/storage/secure_storage.dart';

/// Runtime API environments. Swap the active one in [ApiProvider].
enum ApiEnvironment { prod, dev, local }

String baseUrlFor(ApiEnvironment env) => switch (env) {
  // Replace these with the real backend once it exists.
  ApiEnvironment.prod => dotenv.maybeGet('API_URL_PROD') ?? 'https://api.airsoftcascavel.com.br',
  ApiEnvironment.dev => dotenv.maybeGet('API_URL_DEV') ?? 'https://hml-api.airsoftcascavel.com.br',
  ApiEnvironment.local => dotenv.maybeGet('API_URL_LOCAL') ?? 'http://10.0.2.2:3000',
};

/// Single configured [Dio] client. Injects the bearer token on every request
/// and bounces the user on 401. Extend interceptors here (logging, cache…).
class ApiProvider {
  ApiProvider({required this.ref, required this.secureStorage}) {
    dio.options = BaseOptions(
      baseUrl: baseUrlFor(ApiEnvironment.dev),
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
      headers: {'Connection': 'keep-alive'},
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await secureStorage.readString('authorizationToken');
          if (token != null) {
            options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async => handler.next(error),
      ),
    );
  }

  final Dio dio = Dio();
  final Ref ref;
  final SecureStorage secureStorage;
}

final apiProvider = Provider<ApiProvider>(
  (ref) => ApiProvider(ref: ref, secureStorage: ref.watch(secureStorageProvider)),
);
