import 'package:dio/dio.dart';
import 'package:my_therapy/features/auth/models/auth_response_model.dart';

import '../../../common/exceptions/server_exception.dart';
import '../../../common/network/api_constants.dart';
import '../../../common/network/dio_client.dart';
import 'auth_remote_data_source.dart';
import '../models/message_response_model.dart';

class AuthRemoteDataSourceImpl
    implements AuthRemoteDataSource {

  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioClient.dio.post(
        ApiConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      return AuthResponseModel.fromJson(
        response.data,
      );
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  @override
  Future<AuthResponseModel> registerPatient({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await DioClient.dio.post(
        ApiConstants.registerPatient,
        data: data,
      );

      return AuthResponseModel.fromJson(
        response.data,
      );
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  @override
  Future<AuthResponseModel> registerTherapist({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await DioClient.dio.post(
        ApiConstants.registerTherapist,
        data: data,
      );

      return AuthResponseModel.fromJson(
        response.data,
      );
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }
  
  @override
Future<MessageResponseModel>
sendVerificationCode({
  required String email,
}) async {
  try {
    final response =
        await DioClient.dio.post(
      ApiConstants.sendVerificationCode,
      data: {
        'email': email,
      },
    );

    return MessageResponseModel.fromJson(
      response.data,
    );
  } on DioException catch (e) {
    _handleDioException(e);
  }
}

@override
Future<MessageResponseModel>
verifyEmail({
  required String email,
  required String code,
}) async {
  try {
    final response =
        await DioClient.dio.post(
      ApiConstants.verifyEmail,
      data: {
        'email': email,
        'code': code,
      },
    );

    return MessageResponseModel.fromJson(
      response.data,
    );
  } on DioException catch (e) {
    _handleDioException(e);
  }
}

  Never _handleDioException(
    DioException e,
  ) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {

      // Email already exists
      // Invalid credentials
      if (data.containsKey('Message')) {
        throw ServerException(
          statusCode:
              data['StatusCode'] ??
              e.response?.statusCode ??
              500,
          message: data['Message'],
        );
      }

      // Validation Errors
      if (data.containsKey('errors')) {
        final errors =
            data['errors']
                as Map<String, dynamic>;

        final firstError =
            (errors.values.first as List)
                .first
                .toString();

        throw ServerException(
          statusCode:
              data['status'] ?? 400,
          message: firstError,
        );
      }
    }

    throw ServerException(
      statusCode:
          e.response?.statusCode ?? 500,
      message: 'Something went wrong',
    );
  }
  
}