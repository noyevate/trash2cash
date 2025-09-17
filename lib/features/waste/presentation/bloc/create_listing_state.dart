part of 'create_listing_bloc.dart';

abstract class CreateListingState extends Equatable {
  const CreateListingState();

  @override
  List<Object> get props => [];
}

// The initial state before any action is taken.
class CreateListingInitial extends CreateListingState {}

// The state when the API call is in progress.
// The UI will show a loading indicator when it sees this state.
class CreateListingInProgress extends CreateListingState {}

// The state when the API call is successful.
// It carries the newly created WasteListing object returned by the server.
class CreateListingSuccess extends CreateListingState {
  final WasteListing newListing;

  const CreateListingSuccess(this.newListing);

  @override
  List<Object> get props => [newListing];
}

// The state when the API call fails.
// It carries an error message to be displayed to the user.
class CreateListingFailure extends CreateListingState {
  final String error;

  const CreateListingFailure(this.error);

  @override
  List<Object> get props => [error];
}