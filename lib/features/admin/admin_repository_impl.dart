import 'admin_remote_data_source.dart' show AdminRemoteDataSource;
import 'admin_repository.dart';
import 'pending_therapist_model.dart';

class AdminRepositoryImpl
    implements AdminRepository {
  final AdminRemoteDataSource
      remoteDataSource;

  AdminRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<List<PendingTherapistModel>>
      getPendingTherapists() {
    return remoteDataSource
        .getPendingTherapists();
  }

  @override
  Future<void> approveTherapist(
    String therapistId,
  ) {
    return remoteDataSource
        .approveTherapist(
      therapistId,
    );
  }

  @override
  Future<void> rejectTherapist(
    String therapistId,
  ) {
    return remoteDataSource
        .rejectTherapist(
      therapistId,
    );
  }
}