import 'package:jwt_decoder/jwt_decoder.dart';

import 'secure_storage_service.dart';


class AuthHelper {
  static Future<Map<String, dynamic>?> getClaims() async {
    final token =
        await SecureStorageService().getToken();

    if (token == null) return null;

    return JwtDecoder.decode(token);
  }

  static Future<String?> getUserId() async {
    final claims = await getClaims();

    return claims?[
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];
  }

  static Future<String?> getRole() async {
    final claims = await getClaims();

    return claims?[
        'http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
  }

  static Future<String?> getEmail() async {
    final claims = await getClaims();

    return claims?[
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress'];
  }
}