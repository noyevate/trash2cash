import 'package:trash2cash/features/notification/domain/entities/notiication_item.dart';
abstract class NotificationRepository {
  Future<List<NotificationItem>> getNotifications();
  Future<void> markNotificationAsRead(int notificationId);
  Future<void> markAllNotificationsAsRead();
  Future<int> getUnreadNotificationCount();
}