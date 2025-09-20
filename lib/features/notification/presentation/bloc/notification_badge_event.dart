part of 'notification_badge_bloc.dart';

abstract class NotificationBadgeEvent extends Equatable {
  const NotificationBadgeEvent();
  @override
  List<Object> get props => [];
}

class FetchUnreadCount extends NotificationBadgeEvent {}
class IncrementBadgeCount extends NotificationBadgeEvent {}
class DecrementBadgeCount extends NotificationBadgeEvent {}
class ClearBadgeCount extends NotificationBadgeEvent {}