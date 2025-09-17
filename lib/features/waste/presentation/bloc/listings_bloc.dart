import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash2cash/features/waste/domain/entities/waste_listing.dart';
import 'package:trash2cash/features/waste/domain/entities/waste_listing_items.dart';
import 'package:trash2cash/features/waste/domain/usecases/get_waste_listing.dart';

part 'listings_event.dart';
part 'listings_state.dart';

class ListingsBloc extends Bloc<ListingsEvent, ListingsState> {
  final GetWasteListings _getWasteListings;

  ListingsBloc({required GetWasteListings getWasteListings})
      : _getWasteListings = getWasteListings,
        super(ListingsInitial()) {
    on<FetchListingsRequested>(_onFetchListingsRequested);
  }

  Future<void> _onFetchListingsRequested(
    FetchListingsRequested event,
    Emitter<ListingsState> emit,
  ) async {
    emit(ListingsLoadInProgress());
    try {
      final listings = await _getWasteListings();
      emit(ListingsLoadSuccess(listings));
    } catch (e) {
      emit(ListingsLoadFailure(e.toString()));
    }
  }
}