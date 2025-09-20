

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash2cash/features/waste/domain/entities/recycler_waste_listing.dart';
import 'package:trash2cash/features/waste/domain/usecases/get_all_wase_listing.dart';

part 'recycler_listings_event.dart';
part 'recycler_listings_state.dart';

class RecyclerListingsBloc extends Bloc<RecyclerListingsEvent, RecyclerListingsState> {
  final GetAllWasteListings _getAllListings;

  RecyclerListingsBloc({required GetAllWasteListings getAllListings})
      : _getAllListings = getAllListings,
        super(RecyclerListingsInitial()) {
    on<FetchAllListingsRequested>(_onFetchAllListingsRequested);
  }

  Future<void> _onFetchAllListingsRequested(
    FetchAllListingsRequested event,
    Emitter<RecyclerListingsState> emit,
  ) async {
    // Emit the loading state first to show a spinner in the UI.
    emit(RecyclerListingsInProgress());
    try {
      // Call the use case to fetch the data from the repository.
      final listings = await _getAllListings();
      
      // On success, emit the success state with the fetched data.
      emit(RecyclerListingsLoadSuccess(listings));
    } catch (e) {
      // If any error occurs in the repository or data source,
      // catch it and emit the failure state with the error message.
      emit(RecyclerListingsLoadFailure(e.toString()));
    }
  }
}