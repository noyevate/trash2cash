import 'package:flutter/material.dart';
import 'package:trash2cash/features/schedule/domain/repositories/schedule_repository.dart';

class CreateSchedule {
  final ScheduleRepository repository;

  CreateSchedule(this.repository);

  Future<void> call({
    required int listingId,
    required String pickupLocation,
    required DateTime pickupDate,
    required TimeOfDay pickupTime,
    String? additionalNotes,
  }) {
    return repository.createSchedule(
      listingId: listingId,
      pickupLocation: pickupLocation,
      pickupDate: pickupDate,
      pickupTime: pickupTime,
      additionalNotes: additionalNotes,
    );
  }
}