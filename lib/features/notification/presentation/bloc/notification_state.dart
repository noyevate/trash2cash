part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

// The initial state before any action.
class NotificationInitial extends NotificationState {}

class NotificationLoadInProgress extends NotificationState {}

class NotificationMarkAllInProgress extends NotificationState {}

class NotificationLoadSuccess extends NotificationState {
  final List<NotificationItem> notifications;

  const NotificationLoadSuccess(this.notifications);

  @override
  List<Object> get props => [notifications];
}

class NotificationLoadFailure extends NotificationState {
  final String error;

  const NotificationLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}

