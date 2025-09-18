part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class FetchNotificationsRequested extends NotificationEvent {}

class NotificationMarkedAsRead extends NotificationEvent {
  final int notificationId;

  const NotificationMarkedAsRead(this.notificationId);

  @override
  List<Object> get props => [notificationId];
}

class MarkAllNotificationsAsReadRequested extends NotificationEvent {}