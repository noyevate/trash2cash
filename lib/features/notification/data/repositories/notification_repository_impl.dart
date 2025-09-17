import 'package:trash2cash/core/error/exceptions.dart';
import 'package:trash2cash/features/notification/data/datasources/notification_remote_data_sorce.dart';
import 'package:trash2cash/features/notification/domain/entities/notiication_item.dart';
import 'package:trash2cash/features/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<NotificationItem>> getNotifications() {
    // The repository's primary role is to call the data source and manage the data flow.
    // It also acts as a gatekeeper for errors.
    try {
      // We call the data source to get the list of notifications.
      // The List<NotificationItemModel> returned by the data source is
      // compatible with the Future<List<NotificationItem>> expected by the domain layer.
      return remoteDataSource.getNotifications();
    } on ServerException catch (e) {
      // If the data source throws a ServerException (e.g., due to a 4xx or 5xx status code),
      // we catch it and re-throw it. This ensures the error is passed up
      // cleanly to the BLoC layer, which will then emit a failure state.
      rethrow;
    } catch (e) {
      // It's good practice to also have a generic catch block for unexpected errors
      // (e.g., parsing errors if the API response format is wrong).
      throw ServerException('An unexpected error occurred in the repository: ${e.toString()}');
    }
  }

  // When you add "mark as read" functionality, the implementation would go here.
  // For example:
  /*
  @override
  Future<void> markAllAsRead() {
    try {
      return remoteDataSource.markAllAsRead();
    } on ServerException {
      rethrow;
    }
  }
  */
}