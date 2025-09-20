import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash2cash/features/schedule/domain/usecases/create_shedule.dart'; // Required for DateTime and TimeOfDay

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final CreateSchedule _createSchedule;

  ScheduleBloc({required CreateSchedule createSchedule})
      : _createSchedule = createSchedule,
        super(ScheduleInitial()) {
    on<SchedulePickupRequested>(_onSchedulePickupRequested);
  }

  Future<void> _onSchedulePickupRequested(
    SchedulePickupRequested event,
    Emitter<ScheduleState> emit,
  ) async {
    // Emit the loading state first to update the UI (e.g., show a spinner).
    emit(ScheduleInProgress());
    try {
      // Call the use case with the data from the event.
      await _createSchedule(
        listingId: event.listingId,
        pickupLocation: event.pickupLocation,
        pickupDate: event.pickupDate,
        pickupTime: event.pickupTime,
        additionalNotes: event.additionalNotes,
      );
      
      // If the use case completes without throwing an error, emit the success state.
      emit(ScheduleSuccess());
    } catch (e) {
      // If any error (e.g., a ServerException from the repository) is thrown,
      // catch it and emit the failure state with the error message.
      emit(ScheduleFailure(e.toString()));
    }
  }
}