
import '../../common/network/api_constants.dart';
import '../../common/network/dio_client.dart';
import 'admin_remote_data_source.dart';
import 'pending_therapist_model.dart';

class AdminRemoteDataSourceImpl
    implements AdminRemoteDataSource {

  @override
  Future<List<PendingTherapistModel>>
      getPendingTherapists() async {
      print(DioClient.dio.options.headers);
      
    final response =
        await DioClient.dio.get(
      ApiConstants.pendingTherapists,
    );
    print(response.data);
    print(response.data.length);

    return (response.data as List)
        .map(
          (e) => PendingTherapistModel
              .fromJson(e),
        )
        .toList();
  }

  @override
  Future<void> approveTherapist(
    String therapistId,
  ) async {
    await DioClient.dio.post(
      ApiConstants.approveTherapist(
        therapistId,
      ),
    );
  }

  @override
  Future<void> rejectTherapist(
    String therapistId,
  ) async {
    await DioClient.dio.post(
      ApiConstants.rejectTherapist(
        therapistId,
      ),
    );
  }
}