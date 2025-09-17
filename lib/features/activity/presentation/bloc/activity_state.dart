part of 'activity_bloc.dart';

abstract class ActivityState extends Equatable {
  const ActivityState();

  @override
  List<Object> get props => [];
}

// The initial state before any fetching has begun.
class ActivityInitial extends ActivityState {}

// The state when an API call is in progress for any tab.
class ActivityLoadInProgress extends ActivityState {}

// The state when the API call is successful.
// It holds the list of fetched activities.
class ActivityLoadSuccess extends ActivityState {
  final List<ActivityItem> activities;

  const ActivityLoadSuccess(this.activities);

  @override
  List<Object> get props => [activities];
}

// The state when the API call fails.
// It carries an error message to be displayed to the user.
class ActivityLoadFailure extends ActivityState {
  final String error;

  const ActivityLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}