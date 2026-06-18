import '../enums/user_role.dart';
import '../models/patient_profile_model.dart';
import '../models/therapist_profile_model.dart';
import '../models/user_list_model.dart';
import '../models/user_ui_model.dart';
import '../network/api_constants.dart';
import '../network/dio_client.dart';
import 'auth_helper.dart';
import 'secure_storage_service.dart';
import 'package:dio/dio.dart';

class UserService {
  final dio = DioClient.dio;

  //get patients 
  Future<List<UserListModel>>
    getPatients() async {
  final token =
      await SecureStorageService()
          .getToken();

  final response = await dio.get(
    ApiConstants.getPatients,
    options: Options(
      headers: {
        'Authorization':
            'Bearer $token',
      },
    ),
  );

  return (response.data as List)
      .map(
        (e) => UserListModel.fromJson(e),
      )
      .toList();
}

//get therapist 
Future<List<UserListModel>>
    getTherapists() async {
  final token =
      await SecureStorageService()
          .getToken();

  final response = await dio.get(
    ApiConstants.getTherapists,
    options: Options(
      headers: {
        'Authorization':
            'Bearer $token',
      },
    ),
  );

  return (response.data as List)
      .map(
        (e) => UserListModel.fromJson(e),
      )
      .toList();
}

//patient details
Future<PatientProfileModel>
    getPatientDetails(
  String id,
) async {
  final token =
      await SecureStorageService()
          .getToken();

  final response = await dio.get(
    '${ApiConstants.getPatientById}/$id',
    options: Options(
      headers: {
        'Authorization':
            'Bearer $token',
      },
    ),
  );

  return PatientProfileModel.fromJson(
    response.data,
  );
}
//therapist details 
Future<TherapistProfileModel>
    getTherapistDetails(
  String id,
) async {
  final token =
      await SecureStorageService()
          .getToken();

  final response = await dio.get(
    '${ApiConstants.getTherapistById}/$id',
    options: Options(
      headers: {
        'Authorization':
            'Bearer $token',
      },
    ),
  );

  return TherapistProfileModel.fromJson(
    response.data,
  );
}

// current user 
Future<UserUIModel> getCurrentUser() async {
  final id = await AuthHelper.getUserId();
  final role = await AuthHelper.getRole();
  final claims = await AuthHelper.getClaims();
  print('CLAIMS => $claims');
    print('ID => $id');
  print('ROLE => $role');

  if (id == null || role == null) {
    throw Exception('User not found');
  }

  if (role.toLowerCase() == 'therapist') {
    final therapist =
        await getTherapistDetails(id);

    return UserUIModel(
      name: therapist.fullName,
      imageUrl: therapist.profilePicture,
      role: UserRole.therapist,
    );
  }

  final patient =
      await getPatientDetails(id);

  return UserUIModel(
    name: patient.fullName,
    imageUrl: patient.profilePicture,
    role: UserRole.patient,
  );
}
}