

import 'package:trash2cash/features/waste/domain/entities/recycler_waste_listing.dart';
import 'package:trash2cash/features/waste/domain/repositories/waste_repository.dart';

class GetAllWasteListings {
  final WasteRepository repository;

  GetAllWasteListings(this.repository);

  Future<List<RecyclerWasteListing>> call() {
    return repository.getAllWasteListingsForRecycler();
  }
}