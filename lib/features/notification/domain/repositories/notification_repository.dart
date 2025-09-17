import 'package:trash2cash/features/notification/domain/entities/notiication_item.dart';
abstract class NotificationRepository {
  Future<List<NotificationItem>> getNotifications();
  // We can add these later
  // Future<void> markAsRead(int notificationId);
  // Future<void> markAllAsRead();
}