
import 'package:trash2cash/features/notification/domain/entities/notiication_item.dart';

class NotificationItemModel extends NotificationItem {
  const NotificationItemModel({
    required super.id,
    required super.title,
    required super.message,
    required super.isRead,
    required super.createdAt,
  });

  factory NotificationItemModel.fromJson(Map<String, dynamic> json) {
    return NotificationItemModel(
      id: json['id'] as int,
      title: json['title'] as String,
      message: json['message'] as String,
      isRead: json['readStatus'] as bool, // Maps 'readStatus' to 'isRead'
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}