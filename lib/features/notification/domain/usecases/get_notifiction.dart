import 'package:trash2cash/features/notification/domain/entities/notiication_item.dart';

import '../repositories/notification_repository.dart';

class GetNotifications {
  final NotificationRepository repository;

  GetNotifications(this.repository);

  Future<List<NotificationItem>> call() {
    return repository.getNotifications();
  }
}