import 'package:trash2cash/features/waste/domain/entities/waste_listing_items.dart';

import '../entities/waste_listing.dart';
import '../repositories/waste_repository.dart';

class GetWasteListings {
  final WasteRepository repository;

  GetWasteListings(this.repository);

  Future<List<WasteListingItem>> call() {
    return repository.getWasteListings();
  }
}