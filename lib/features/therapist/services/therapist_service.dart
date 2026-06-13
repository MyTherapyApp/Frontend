import '../models/therapist_availability_model.dart';

abstract class TherapistService {
  Future<List<TherapistAvailabilityModel>>
      getMyAvailability();

  Future<void> addAvailability({
  required DateTime startTime,
  required DateTime endTime,
});

Future<void> deleteAvailability(
  String slotId,
);
}