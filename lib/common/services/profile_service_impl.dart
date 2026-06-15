
import 'package:dio/dio.dart';

import '../models/upload_picture_response.dart';
import '../network/api_constants.dart';
import '../network/dio_client.dart';
import 'profile_service.dart';
import 'secure_storage_service.dart';

class ProfileServiceImpl
    implements ProfileService {

  final Dio dio = DioClient.dio;

  final SecureStorageService storage =
      SecureStorageService();

  @override
  Future<UploadPictureResponse>
      uploadProfilePicture(
    String filePath,
  ) async {

    final token =
        await storage.getToken();

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        filePath,
        filename:
            filePath.split('/').last,
      ),
    });

    final response = await dio.post(
      ApiConstants.uploadPicture,
      data: formData,
      options: Options(
        headers: {
          'Authorization':
              'Bearer $token',
        },
      ),
    );

    return UploadPictureResponse.fromJson(
      response.data,
    );
  }
}