import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash2cash/features/notification/domain/entities/notiication_item.dart';
import 'package:trash2cash/features/notification/domain/usecases/get_notifiction.dart';


part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotifications _getNotifications;

  NotificationBloc({required GetNotifications getNotifications})
      : _getNotifications = getNotifications,
        super(NotificationInitial()) {
    on<FetchNotificationsRequested>(_onFetchNotificationsRequested);
  }

  Future<void> _onFetchNotificationsRequested(
    FetchNotificationsRequested event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoadInProgress());
    try {
      final notifications = await _getNotifications();
      
      // --- CUSTOM SORTING LOGIC ---
      notifications.sort((a, b) {
        // First, sort by read status (false/unread comes first)
        if (a.isRead != b.isRead) {
          return a.isRead ? 1 : -1; // If a is read and b is not, b comes first
        }
        // If read status is the same, sort by date (newest first)
        return b.createdAt.compareTo(a.createdAt);
      });
      
      emit(NotificationLoadSuccess(notifications));
    } catch (e) {
      emit(NotificationLoadFailure(e.toString()));
    }
  }
}