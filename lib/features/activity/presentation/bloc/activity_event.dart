part of 'activity_bloc.dart';

abstract class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object> get props => [];
}

// Event dispatched when a tab becomes visible or needs to refresh its data.
// It carries the 'type' of activity to fetch, corresponding to the tab.
class FetchActivitiesRequested extends ActivityEvent {
  final ActivityType type;

  const FetchActivitiesRequested(this.type);

  @override
  List<Object> get props => [type];
}