import 'pending_therapist_model.dart';

abstract class AdminRemoteDataSource {
  Future<List<PendingTherapistModel>>
      getPendingTherapists();

  Future<void> approveTherapist(
    String therapistId,
  );

  Future<void> rejectTherapist(
    String therapistId,
  );
}