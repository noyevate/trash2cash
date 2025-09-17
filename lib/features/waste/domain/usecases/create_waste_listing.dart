

import 'dart:io';

import 'package:trash2cash/features/waste/domain/entities/waste_listing.dart';
import 'package:trash2cash/features/waste/domain/repositories/waste_repository.dart';

class CreateWasteListing {
  final WasteRepository repository;

  CreateWasteListing(this.repository);

  Future<WasteListing> call({
    required String title,
    required String description,
    required String pickupLocation,
    required Type type,
    required double unit,
    required double weight,
    required String contactPhone,
    required File image,
  }) {
    return repository.createWasteListing(
      title: title,
      description: description,
      pickupLocation: pickupLocation,
      type: type,
      unit: unit,
      weight: weight,
      contactPhone: contactPhone,
      image: image,
    );
  }
}