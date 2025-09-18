
import 'package:trash2cash/features/notification/domain/repositories/notification_repository.dart';

class MarkNotificationAsRead {
  final NotificationRepository repository;

  MarkNotificationAsRead(this.repository);

  // The use case takes the ID and calls the repository.
  Future<void> call(int notificationId) {
    return repository.markNotificationAsRead(notificationId);
  }
}