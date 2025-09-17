part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

// The initial state before any action.
class NotificationInitial extends NotificationState {}

// The state when the API call is in progress.
class NotificationLoadInProgress extends NotificationState {}

// The state when notifications have been successfully fetched.
// It holds the sorted list of notifications.
class NotificationLoadSuccess extends NotificationState {
  final List<NotificationItem> notifications;

  const NotificationLoadSuccess(this.notifications);

  @override
  List<Object> get props => [notifications];
}

// The state when fetching notifications has failed.
class NotificationLoadFailure extends NotificationState {
  final String error;

  const NotificationLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}