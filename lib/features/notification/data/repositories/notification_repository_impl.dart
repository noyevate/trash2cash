import 'package:trash2cash/core/error/exceptions.dart';
import 'package:trash2cash/features/notification/data/datasources/notification_remote_data_sorce.dart';
import 'package:trash2cash/features/notification/domain/entities/notiication_item.dart';
import 'package:trash2cash/features/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<NotificationItem>> getNotifications() {
    
    try {
      return remoteDataSource.getNotifications();
    } on ServerException catch (e) {
      
      rethrow;
    } catch (e) {
      throw ServerException('An unexpected error occurred in the repository: ${e.toString()}');
    }
  }

   @override
  Future<void> markNotificationAsRead(int notificationId) {
    try {
      return remoteDataSource.markNotificationAsRead(notificationId);
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<void> markAllNotificationsAsRead() {
    try {
      return remoteDataSource.markAllNotificationsAsRead();
    } on ServerException {
      rethrow;
    }
  }
}