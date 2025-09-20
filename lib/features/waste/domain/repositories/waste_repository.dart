

import 'dart:io';

import 'package:trash2cash/features/waste/domain/entities/recycler_waste_listing.dart';
import 'package:trash2cash/features/waste/domain/entities/waste_listing.dart';
import 'package:trash2cash/features/waste/domain/entities/waste_listing_items.dart';

abstract class WasteRepository {
  Future<WasteListing> createWasteListing({
    required String title,
    required String description,
    required String pickupLocation,
    required Type type,
    required double unit,
    required double weight,
    required String contactPhone,
    required File image,
  });

  Future<List<WasteListingItem>> getWasteListings();
  Future<List<RecyclerWasteListing>> getAllWasteListingsForRecycler();
}