

import 'dart:io';

import 'package:trash2cash/core/error/exceptions.dart';
import 'package:trash2cash/features/waste/data/datasources/waste_listing_remote_data_source.dart';
import 'package:trash2cash/features/waste/domain/entities/waste_listing.dart';
import 'package:trash2cash/features/waste/domain/entities/waste_listing_items.dart';
import 'package:trash2cash/features/waste/domain/repositories/waste_repository.dart';



class WasteRepositoryImpl implements WasteRepository {
  final WasteRemoteDataSource remoteDataSource;

  WasteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<WasteListing> createWasteListing({
    // These parameters come from the use case
    required String title,
    required String description,
    required String pickupLocation,
    required Type type,
    required double unit,
    required double weight,
    required String contactPhone,
    required File image,
  }) {
    // The repository's job is to call the data source and handle errors.
    try {
      // Pass all the parameters down to the remote data source
      return remoteDataSource.createWasteListing(
        title: title,
        description: description,
        pickupLocation: pickupLocation,
        type: type,
        unit: unit,
        weight: weight,
        contactPhone: contactPhone,
        image: image,
      );
    } on ServerException {
      rethrow;
    }
  }



  @override
  Future<List<WasteListingItem>> getWasteListings() {
    try {
      return remoteDataSource.getWasteListings();
    } on ServerException {
      rethrow;
    }
  }
}