part of 'notification_badge_bloc.dart';

enum BadgeStatus { initial, loading, success, failure }

class NotificationBadgeState extends Equatable {
  final int count;
  final BadgeStatus status;
  
  const NotificationBadgeState({required this.count, required this.status});
  
  NotificationBadgeState copyWith({int? count, BadgeStatus? status}) {
    return NotificationBadgeState(
      count: count ?? this.count,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [count, status];
}