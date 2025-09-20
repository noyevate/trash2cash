part of 'schedule_bloc.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

// The initial state before the user has tried to submit.
class ScheduleInitial extends ScheduleState {}

// The state when the API call to create the schedule is in progress.
// The UI will show a loading indicator on the button when it sees this state.
class ScheduleInProgress extends ScheduleState {}

// The state when the schedule has been successfully created.
// The UI listener will react to this to show a success message and navigate away.
class ScheduleSuccess extends ScheduleState {}

// The state when an error occurred while creating the schedule.
// It holds an error message to be displayed to the user.
class ScheduleFailure extends ScheduleState {
  final String error;

  const ScheduleFailure(this.error);

  @override
  List<Object> get props => [error];
}