import 'package:flutter/material.dart'; // For TimeOfDay

abstract class ScheduleRepository {
  Future<void> createSchedule({
    required int listingId,
    required String pickupLocation,
    required DateTime pickupDate,
    required TimeOfDay pickupTime,
    String? additionalNotes,
  });
}