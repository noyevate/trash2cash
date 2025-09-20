part of 'recycler_listings_bloc.dart';

abstract class RecyclerListingsState extends Equatable {
  const RecyclerListingsState();

  @override
  List<Object> get props => [];
}

// The initial state of the BLoC before any events have been processed.
class RecyclerListingsInitial extends RecyclerListingsState {}

// The state indicating that the API call to fetch listings is currently in progress.
// The UI should show a loading indicator (e.g., CircularProgressIndicator).
class RecyclerListingsInProgress extends RecyclerListingsState {}

// The state indicating that the listings were fetched successfully.
// It holds the list of listings to be displayed by the UI.
class RecyclerListingsLoadSuccess extends RecyclerListingsState {
  final List<RecyclerWasteListing> listings;

  const RecyclerListingsLoadSuccess(this.listings);

  @override
  List<Object> get props => [listings];
}

// The state indicating that an error occurred while fetching the listings.
// It holds an error message to be displayed to the user.
class RecyclerListingsLoadFailure extends RecyclerListingsState {
  final String error;

  const RecyclerListingsLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}