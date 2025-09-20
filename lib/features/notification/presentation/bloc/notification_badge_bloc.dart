import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash2cash/features/notification/domain/usecases/get_unread_notification_count.dart';

part 'notification_badge_event.dart';
part 'notification_badge_state.dart';

class NotificationBadgeBloc extends Bloc<NotificationBadgeEvent, NotificationBadgeState> {
  final GetUnreadNotificationCount _getUnreadCount;

  NotificationBadgeBloc({required GetUnreadNotificationCount getUnreadCount})
      : _getUnreadCount = getUnreadCount,
        super(const NotificationBadgeState(count: 0, status: BadgeStatus.initial)) {
    on<FetchUnreadCount>(_onFetchUnreadCount);
    on<IncrementBadgeCount>(_onIncrementBadgeCount);
    on<DecrementBadgeCount>(_onDecrementBadgeCount);
    on<ClearBadgeCount>(_onClearBadgeCount);
  }

  Future<void> _onFetchUnreadCount(
    FetchUnreadCount event,
    Emitter<NotificationBadgeState> emit,
  ) async {
    emit(state.copyWith(status: BadgeStatus.loading));
    try {
      final count = await _getUnreadCount();
      emit(state.copyWith(count: count, status: BadgeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: BadgeStatus.failure));
    }
  }
  
  // Optimistic updates for a responsive UI
  void _onIncrementBadgeCount(IncrementBadgeCount event, Emitter<NotificationBadgeState> emit) {
    emit(state.copyWith(count: state.count + 1));
  }

  void _onDecrementBadgeCount(DecrementBadgeCount event, Emitter<NotificationBadgeState> emit) {
    if (state.count > 0) {
      emit(state.copyWith(count: state.count - 1));
    }
  }

  void _onClearBadgeCount(ClearBadgeCount event, Emitter<NotificationBadgeState> emit) {
    emit(state.copyWith(count: 0));
  }
}