import 'package:dio/dio.dart';

import '../../../common/network/api_constants.dart';
import '../../../common/network/dio_client.dart';
import '../../../common/services/secure_storage_service.dart';
import '../models/therapist_availability_model.dart';
import 'therapist_service.dart';

class TherapistServiceImpl
    implements TherapistService {

  final Dio dio = DioClient.dio;
  final SecureStorageService storage =
      SecureStorageService();

  @override
  Future<List<TherapistAvailabilityModel>>
      getMyAvailability() async {

    final token =
        await storage.getToken();

    final response = await dio.get(
      ApiConstants.therapistAvailabilityMy,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    return (response.data as List)
        .map(
          (e) =>
              TherapistAvailabilityModel
                  .fromJson(e),
        )
        .toList();
  }

  //Add Availability

  @override
Future<void> addAvailability({
  required DateTime startTime,
  required DateTime endTime,
}) async {
  final token =
      await storage.getToken();

  await dio.post(
    ApiConstants.therapistAvailability,
    data: {
      'startTime':
          startTime.toIso8601String(),
      'endTime':
          endTime.toIso8601String(),
    },
    options: Options(
      headers: {
        'Authorization':
            'Bearer $token',
      },
    ),
  );
}
//Delete
@override
Future<void> deleteAvailability(
  String slotId,
) async {
  final token =
      await storage.getToken();

  await dio.delete(
    ApiConstants.deleteAvailability(
      slotId,
    ),
    options: Options(
      headers: {
        'Authorization':
            'Bearer $token',
      },
    ),
  );
}
}