import '../models/therapist_availability_model.dart';

abstract class AvailabilityState {}

class AvailabilityInitial
    extends AvailabilityState {}

class AvailabilityLoading
    extends AvailabilityState {}

class AvailabilityLoaded
    extends AvailabilityState {
  final List<TherapistAvailabilityModel>
      slots;

  AvailabilityLoaded(this.slots);
}

class AvailabilityError
    extends AvailabilityState {
  final String message;

  AvailabilityError(this.message);
}