import 'package:dio/dio.dart';

import '../../../common/network/api_constants.dart';
import '../../../common/network/dio_client.dart';
import '../../../common/services/auth_helper.dart';
import '../../../common/services/secure_storage_service.dart';
import '../models/therapist_profile_model.dart';

class TherapistProfileService {
  Future<TherapistProfileModel> getTherapistProfile() async {
    final token =
        await SecureStorageService().getToken();

    final id =
        await AuthHelper.getUserId();

    print('TOKEN => $token');
    print('USER ID => $id');

    try {
      final url =
          '${ApiConstants.getTherapistById}/$id';

      print('URL => $url');

      final response =
          await DioClient.dio.get(
        url,
        options: Options(
          headers: {
            'Authorization':
                'Bearer $token',
          },
        ),
      );

      print(
        'STATUS => ${response.statusCode}',
      );

      print(
        'DATA => ${response.data}',
      );

      return TherapistProfileModel.fromJson(
        response.data,
      );
    } on DioException catch (e) {
      print(
        'STATUS => ${e.response?.statusCode}',
      );

      print(
        'DATA => ${e.response?.data}',
      );

      print(
        'PATH => ${e.requestOptions.path}',
      );

      print(
        'MESSAGE => ${e.message}',
      );

      rethrow;
    } catch (e) {
      print(
        'ERROR => $e',
      );

      rethrow;
    }
  }
}