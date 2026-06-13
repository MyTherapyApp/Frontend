import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const FlutterSecureStorage _storage =
      FlutterSecureStorage();

  static const String tokenKey = 'token';
  static const String expirationKey = 'expiration';

  Future<void> saveToken(
    String token,
  ) async {
    await _storage.write(
      key: tokenKey,
      value: token,
    );
  }

  Future<String?> getToken() async {
    return await _storage.read(
      key: tokenKey,
    );
  }

  Future<void> deleteToken() async {
    await _storage.delete(
      key: tokenKey,
    );
    await _storage.delete(
    key: expirationKey,
  );
  }

  Future<bool> hasToken() async {
  final token = await getToken();
  return token != null;
}

Future<void> saveExpiration(
  String expiration,
) async {
  await _storage.write(
    key: expirationKey,
    value: expiration,
  );
}
Future<String?> getExpiration() async {
  return await _storage.read(
    key: expirationKey,
  );
}
}