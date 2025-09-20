
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trash2cash/core/error/exceptions.dart';
import 'package:trash2cash/features/schedule/data/datasources/schedule_remote_data_source.dart';
import 'package:trash2cash/features/schedule/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource remoteDataSource;

  ScheduleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createSchedule({
    required int listingId,
    required String pickupLocation,
    required DateTime pickupDate,
    required TimeOfDay pickupTime,
    String? additionalNotes,
  }) {
    try {
      final String formattedDate = DateFormat('yyyy-MM-dd').format(pickupDate);
      final String formattedTime = "${pickupTime.hour.toString().padLeft(2, '0')}:${pickupTime.minute.toString().padLeft(2, '0')}";
      
      return remoteDataSource.createSchedule(
        listingId: listingId,
        pickupLocation: pickupLocation,
        pickupDate: formattedDate,
        pickupTime: formattedTime,
        additionalNotes: additionalNotes,
      );
    } on ServerException {
      rethrow;
    }
  }
}