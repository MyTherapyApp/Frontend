import 'package:flutter_bloc/flutter_bloc.dart';

import 'admin_repository.dart';
import 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final AdminRepository repository;

  AdminCubit(this.repository)
      : super(AdminInitial());

  Future<void>
      getPendingTherapists() async {
    emit(AdminLoading());

    try {
      final therapists =
          await repository
              .getPendingTherapists();

      emit(
        PendingTherapistsLoaded(
          therapists,
        ),
      );
    } catch (e) {
      emit(
        AdminFailure(
          e.toString(),
        ),
      );
    }
  }
  Future<void> approveTherapist(
  String therapistId,
) async {
  emit(AdminActionLoading());
  try {
    await repository.approveTherapist(
      therapistId,
    );

    emit(
      AdminActionSuccess(
        'Therapist approved successfully',
      ),
    );

    await getPendingTherapists();
  } catch (e) {
    emit(
      AdminFailure(
        e.toString(),
      ),
    );
  }
}
Future<void> rejectTherapist(
  String therapistId,
) async {
  emit(AdminActionLoading());
  try {
    await repository.rejectTherapist(
      therapistId,
    );

    emit(
      AdminActionSuccess(
        'Therapist rejected successfully',
      ),
    );

    await getPendingTherapists();
  } catch (e) {
    emit(
      AdminFailure(
        e.toString(),
      ),
    );
  }
}
}