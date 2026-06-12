import 'package:dio/dio.dart';
import '../../../common/errors/failure.dart';
import '../../../common/exceptions/server_exception.dart';
import '../models/auth_response_model.dart';
import 'auth_remote_data_source.dart';
import 'auth_repository.dart';
import '../models/message_response_model.dart';
import '../models/verification_status_model.dart';

class AuthRepositoryImpl
    implements AuthRepository {

  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      return await remoteDataSource.login(
        email: email,
        password: password,
      );
    } on ServerException catch (e) {
      throw Failure(
        statusCode: e.statusCode,
        message: e.message,
      );
    }
  }

@override
Future<AuthResponseModel>
registerPatient({
  required Map<String, dynamic> data,
}) async {
  try {
    return await remoteDataSource
        .registerPatient(
      data: data,
    );
  } on ServerException catch (e) {
    throw Failure(
      statusCode: e.statusCode,
      message: e.message,
    );
  }
}

  @override
  Future<AuthResponseModel> registerTherapist({
    required Map<String, dynamic> data,
  }) async {
    try {
      return await remoteDataSource
          .registerTherapist(
        data: data,
      );
    } on ServerException catch (e) {
      throw Failure(
        statusCode: e.statusCode,
        message: e.message,
      );
    }
  }
  @override
Future<MessageResponseModel>
sendVerificationCode({
  required String email,
}) async {
  try {
    return await remoteDataSource
        .sendVerificationCode(
      email: email,
    );
  } on ServerException catch (e) {
    throw Failure(
      statusCode: e.statusCode,
      message: e.message,
    );
  }
}
@override
Future<MessageResponseModel>
verifyEmail({
  required String email,
  required String code,
}) async {
  try {
    return await remoteDataSource
        .verifyEmail(
      email: email,
      code: code,
    );
  } on ServerException catch (e) {
    throw Failure(
      statusCode: e.statusCode,
      message: e.message,
    );
  }
}
@override
Future<MessageResponseModel>
uploadLicense({
  required MultipartFile file,
}) async {
  try {
    return await remoteDataSource
        .uploadLicense(
      file: file,
    );
  } on ServerException catch (e) {
    throw Failure(
      statusCode: e.statusCode,
      message: e.message,
    );
  }
}
@override
Future<VerificationStatusModel>
getVerificationStatus() async {
  try {
    return await remoteDataSource
        .getVerificationStatus();
  } on ServerException catch (e) {
    throw Failure(
      statusCode: e.statusCode,
      message: e.message,
    );
  }
}
}