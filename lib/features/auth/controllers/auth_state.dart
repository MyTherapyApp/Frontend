import '../models/auth_response_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthResponseModel authResponse;

  AuthSuccess({
    required this.authResponse,
  });
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({
    required this.message,
  });
}

class VerificationCodeSent
    extends AuthState {
  final String message;

  VerificationCodeSent({
    required this.message,
  });
}
class EmailVerified
    extends AuthState {
  final String message;

  EmailVerified({
    required this.message,
  });
}