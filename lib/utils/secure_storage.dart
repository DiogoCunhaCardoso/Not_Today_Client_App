import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  // Store token securely
  static Future<void> storeToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  // Retrieve the token
  static Future<String?> retrieveToken() async {
    return await _storage.read(key: 'auth_token');
  }

  // Delete the token (e.g., during logout)
  static Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }
}
