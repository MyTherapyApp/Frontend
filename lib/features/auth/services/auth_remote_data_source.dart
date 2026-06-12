import '../models/auth_response_model.dart';
import '../models/message_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  });

  Future<AuthResponseModel>
registerPatient({
  required Map<String, dynamic> data,
});

  Future<AuthResponseModel> registerTherapist({
    required Map<String, dynamic> data,
  });

  Future<MessageResponseModel>
sendVerificationCode({
  required String email,
});

Future<MessageResponseModel>
verifyEmail({
  required String email,
  required String code,
});
}
