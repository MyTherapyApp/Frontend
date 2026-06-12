import 'package:jwt_decoder/jwt_decoder.dart';

class AuthResponseModel {
  final String token;
  final DateTime expiration;

  AuthResponseModel({
    required this.token,
    required this.expiration,
  });

  factory AuthResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AuthResponseModel(
      token: json['token'],
      expiration: DateTime.parse(
        json['expiration'],
      ),
    );
  }

  Map<String, dynamic> get claims =>
      JwtDecoder.decode(token);

  String get userId =>
      claims[
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'] ??
      '';

  String get email =>
      claims[
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress'] ??
      '';

  String get role =>
      claims[
          'http://schemas.microsoft.com/ws/2008/06/identity/claims/role'] ??
      '';

  bool get isExpired =>
      JwtDecoder.isExpired(token);
}