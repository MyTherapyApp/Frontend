import 'pending_therapist_model.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}
class AdminActionLoading extends AdminState {}

class PendingTherapistsLoaded
    extends AdminState {
  final List<PendingTherapistModel>
      therapists;

  PendingTherapistsLoaded(
    this.therapists,
  );
}

class AdminActionSuccess
    extends AdminState {
  final String message;

  AdminActionSuccess(
    this.message,
  );
}

class AdminFailure extends AdminState {
  final String message;

  AdminFailure(
    this.message,
  );
}