import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash2cash/features/notification/domain/entities/notiication_item.dart';
import 'package:trash2cash/features/notification/domain/usecases/get_notifiction.dart';
import 'package:trash2cash/features/notification/domain/usecases/mark_all_notification_as_read.dart';
import 'package:trash2cash/features/notification/domain/usecases/mark_notification_as_read.dart';


part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotifications _getNotifications;
  final MarkNotificationAsRead _markNotificationAsRead;
  final MarkAllNotificationsAsRead _markAllNotificationsAsRead;

  NotificationBloc({required GetNotifications getNotifications, required MarkNotificationAsRead markNotificationAsRead,  required MarkAllNotificationsAsRead markAllNotificationsAsRead,})
      : _getNotifications = getNotifications,
      _markNotificationAsRead = markNotificationAsRead,
       _markAllNotificationsAsRead = markAllNotificationsAsRead,
        super(NotificationInitial()) {
    on<FetchNotificationsRequested>(_onFetchNotificationsRequested);
    on<NotificationMarkedAsRead>(_onNotificationMarkedAsRead);
    on<MarkAllNotificationsAsReadRequested>(_onMarkAllNotificationsAsReadRequested); 
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

  Future<void> _onNotificationMarkedAsRead(
    NotificationMarkedAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await _markNotificationAsRead(event.notificationId);
      print('Successfully marked notification ${event.notificationId} as read on the server.');
    } catch (e) {
      // In a real app, you might log this error to a service like Sentry,
      // but you typically don't show a UI error to the user for this background action.
      print('Failed to mark notification as read on server: $e');
    }

    
    if (state is NotificationLoadSuccess) {
      final currentState = state as NotificationLoadSuccess;
      
      final updatedNotifications = currentState.notifications.map((notification) {
        if (notification.id == event.notificationId) {
          
          return notification.copyWith(isRead: true);
        }
        return notification;
      }).toList();

      // Re-sort the list so the newly read item moves to the bottom.
       updatedNotifications.sort((a, b) {
        if (a.isRead != b.isRead) return a.isRead ? 1 : -1;
        return b.createdAt.compareTo(a.createdAt);
      });

      // Emit the new success state with the updated list.
      emit(NotificationLoadSuccess(updatedNotifications));
    }
  }

  Future<void> _onMarkAllNotificationsAsReadRequested(
    MarkAllNotificationsAsReadRequested event,
    Emitter<NotificationState> emit,
  ) async {
    // We need the current list to update it, so only proceed if we have one.
    if (state is NotificationLoadSuccess) {
      final currentState = state as NotificationLoadSuccess;
      
      emit(NotificationMarkAllInProgress()); // Emit loading state
      
      try {
        await _markAllNotificationsAsRead();

        // On success, update the local state to reflect the change.
        final updatedNotifications = currentState.notifications.map((n) {
          // If a notification is already read, keep it as is.
          // If it's unread, create a new instance with isRead: true.
          return n.isRead ? n : n.copyWith(isRead: true);
        }).toList();
        
        // The sorting remains the same, but now all items will be at the bottom.
        updatedNotifications.sort((a, b) {
            if (a.isRead != b.isRead) return a.isRead ? 1 : -1;
            return b.createdAt.compareTo(a.createdAt);
        });

        emit(NotificationLoadSuccess(updatedNotifications));
      } catch (e) {
        // On failure, you can show an error and revert to the previous success state.
        emit(NotificationLoadFailure(e.toString()));
        // Optionally, re-emit the original state to remove the loading indicator
        await Future.delayed(const Duration(seconds: 2));
        emit(currentState);
      }
    }
  }
}