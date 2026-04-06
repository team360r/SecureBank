import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Chapter 2: Secure storage backed by Keychain (iOS) and EncryptedSharedPreferences (Android).
class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
        );

  Future<void> saveToken(String token) =>
      _storage.write(key: 'session_token', value: token);

  Future<String?> getToken() => _storage.read(key: 'session_token');

  Future<void> deleteToken() => _storage.delete(key: 'session_token');

  Future<void> saveApiKey(String key) =>
      _storage.write(key: 'api_key', value: key);

  Future<String?> getApiKey() => _storage.read(key: 'api_key');

  Future<void> clearAll() => _storage.deleteAll();
}
