import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/therapist_service.dart';
import 'availability_state.dart';

class AvailabilityCubit
    extends Cubit<AvailabilityState> {

  final TherapistService
      therapistService;

  AvailabilityCubit(
    this.therapistService,
  ) : super(
          AvailabilityInitial(),
        );

  Future<void>
      getMyAvailability() async {
    emit(
      AvailabilityLoading(),
    );

    try {
      final slots =
          await therapistService
              .getMyAvailability();

      emit(
        AvailabilityLoaded(
          slots,
        ),
      );
    } catch (e) {
      emit(
        AvailabilityError(
          e.toString(),
        ),
      );
    }
  }

  // Add Availability
  Future<void> addAvailability({
  required DateTime startTime,
  required DateTime endTime,
}) async {
  try {
    await therapistService.addAvailability(
      startTime: startTime,
      endTime: endTime,
    );

    await getMyAvailability();
  } catch (e) {
    emit(
      AvailabilityError(
        e.toString(),
      ),
    );
  }
}

// Delete
Future<void> deleteAvailability(
  String slotId,
) async {
  try {
    await therapistService
        .deleteAvailability(
      slotId,
    );

    await getMyAvailability();
  } catch (e) {
    emit(
      AvailabilityError(
        e.toString(),
      ),
    );
  }
}
}