part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

// Event dispatched when the NotificationPage loads or user pulls to refresh.
class FetchNotificationsRequested extends NotificationEvent {}