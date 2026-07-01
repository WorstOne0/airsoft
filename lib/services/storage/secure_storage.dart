// Flutter packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Encrypted key/value storage for sensitive data (auth tokens, credentials).
/// - iOS: Keychain
/// - Android: AES, with the key protected by the platform KeyStore.
class SecureStorage {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  Future<bool> saveString(String key, String value) async {
    try {
      await storage.write(key: key, value: value);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String?> readString(String key) async {
    try {
      return await storage.read(key: key);
    } catch (_) {
      return null;
    }
  }

  Future<void> deleteKey(String key) async => storage.delete(key: key);

  Future<void> clear() async => storage.deleteAll();
}

final secureStorageProvider = Provider<SecureStorage>((ref) => SecureStorage());
