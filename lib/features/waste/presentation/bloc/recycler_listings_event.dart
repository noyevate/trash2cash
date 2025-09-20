part of 'recycler_listings_bloc.dart';

abstract class RecyclerListingsEvent extends Equatable {
  const RecyclerListingsEvent();

  @override
  List<Object> get props => [];
}

// This event is dispatched from the UI (e.g., in initState or on a pull-to-refresh)
// to tell the BLoC to fetch the list of all available waste.
class FetchAllListingsRequested extends RecyclerListingsEvent {}