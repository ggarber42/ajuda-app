import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyClientId = 'client_id';
  static const _keyClientSecret = 'client_secret';
  static const _keyRefreshToken = 'refresh_token';

  static Future setClientId(String clientId) async =>
      await _storage.write(key: _keyClientId, value: clientId);

  static Future<String?> getClientId() async =>
      await _storage.read(key: _keyClientId);

  static Future setClientSecret(String clientSecret) async =>
      await _storage.write(key: _keyClientSecret, value: clientSecret);

  static Future<String?> getClientSecret() async =>
      await _storage.read(key: _keyClientSecret);

  static Future setRefreshToken(String refreshToken) async =>
      await _storage.write(key: _keyRefreshToken, value: refreshToken);

  static Future<String?> getRefreshToken() async =>
      await _storage.read(key: _keyRefreshToken);
}
