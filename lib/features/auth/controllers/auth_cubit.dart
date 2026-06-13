import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../common/errors/failure.dart';
import '../../../common/network/dio_client.dart';
import '../../../common/services/secure_storage_service.dart';
import '../services/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  final SecureStorageService storage;

  AuthCubit({
    required this.repository,
    required this.storage,
  }) : super(AuthInitial());

  // Login
    Future<void> login({
  required String email,
  required String password,
}) async {
  emit(AuthLoading());

  try {
    final response =
        await repository.login(
      email: email,
      password: password,
    );

    await storage.saveToken(
      response.token,
    );
    await storage.saveExpiration(
  response.expiration.toIso8601String(),
);
    DioClient.dio.options.headers[
    'Authorization'
    ] = 'Bearer ${response.token}';
    emit(AuthSuccess(
      authResponse: response,
    ));
  } on Failure catch (e) {
    emit(
      AuthFailure(
        message: e.message,
      ),
    );
  }
}
// Verification
Future<void> sendVerificationCode({
  required String email,
}) async {
  emit(AuthLoading());

  try {
    final response =
        await repository
            .sendVerificationCode(
      email: email,
    );

    emit(
      VerificationCodeSent(
        message: response.message,
      ),
    );
  } on Failure catch (e) {
    emit(
      AuthFailure(
        message: e.message,
      ),
    );
  }
}
Future<void> verifyEmail({
  required String email,
  required String code,
}) async {
  emit(AuthLoading());

  try {
    final response =
        await repository.verifyEmail(
      email: email,
      code: code,
    );

    emit(
      EmailVerified(
        message: response.message,
      ),
    );
  } on Failure catch (e) {
    emit(
      AuthFailure(
        message: e.message,
      ),
    );
  }
}

//patirnt register
Future<void> registerPatient({
  required String fullName,
  required String email,
  required String password,
  required String phone,
  required int gender,
  required DateTime dateOfBirth,
  required bool isAnonymous,
}) async {
  emit(AuthLoading());

  try {
    final response =
        await repository.registerPatient(
      data: {
        'fullName': fullName,
        'email': email,
        'password': password,
        'phone': phone,
        'gender': gender,
        'dateOfBirth':
            dateOfBirth.toIso8601String(),
        'isAnonymous': isAnonymous,
      },
    );

    await storage.saveToken(
      response.token,
    );
    await storage.saveExpiration(
  response.expiration.toIso8601String(),
);

    emit(
      AuthSuccess(
        authResponse: response,
      ),
    );
  } on Failure catch (e) {
    emit(
      AuthFailure(
        message: e.message,
      ),
    );
  }
}
// therapist register 
Future<void> registerTherapist({
  required String fullName,
  required String email,
  required String password,
  required String phone,
  required int gender,
  required DateTime dateOfBirth,
  required bool isAnonymous,
  required String specialization,
  required String licenseNumber,
}) async {
  emit(AuthLoading());

  try {
    final response =
        await repository.registerTherapist(
      data: {
        'fullName': fullName,
        'email': email,
        'password': password,
        'phone': phone,
        'gender': gender,
        'dateOfBirth':
            dateOfBirth.toIso8601String(),
        'isAnonymous': isAnonymous,
        'specialization':
            specialization,
        'licenseNumber':
            licenseNumber,
      },
    );

    await storage.saveToken(
      response.token,
    );
    await storage.saveExpiration(
  response.expiration.toIso8601String(),
);
    

    emit(
      AuthSuccess(
        authResponse: response,
      ),
    );
  } on Failure catch (e) {
    emit(
      AuthFailure(
        message: e.message,
      ),
    );
  }
}

// Upload License
Future<void> uploadLicense({
  required String filePath,
  required String fileName,
}) async {
  emit(AuthLoading());

  try {
    print('FILE PATH => $filePath');
    print('FILE NAME => $fileName');

    print(
      'HEADERS => ${DioClient.dio.options.headers}',
    );
    final file = await MultipartFile.fromFile(
      filePath,
      filename: fileName,
    );

    final response =
        await repository.uploadLicense(
      file: file,
    );
print(
      'UPLOAD SUCCESS => ${response.message}',
    );
    emit(
      LicenseUploaded(
        message: response.message,
      ),
    );
  } on Failure catch (e) {
    print(
      'UPLOAD FAILURE => ${e.message}',
    );

    emit(
      AuthFailure(
        message: e.message,
      ),
    );
  }
}

// Verification Status
Future<void> getVerificationStatus() async {
  emit(AuthLoading());

  try {
    final status =
        await repository.getVerificationStatus();

    emit(
      VerificationStatusLoaded(
        status: status,
      ),
    );
  } on Failure catch (e) {
    emit(
      AuthFailure(
        message: e.message,
      ),
    );
  }
}

//Logout 
Future<void> logout() async {
  await storage.deleteToken();

  DioClient.dio.options.headers
      .remove('Authorization');

  emit(AuthInitial());
}
}