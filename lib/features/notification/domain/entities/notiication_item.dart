import 'package:equatable/equatable.dart';

class NotificationItem extends Equatable {
  final int id;
  final String title;
  final String message;
  final bool isRead; // Renamed for clarity (readStatus -> isRead)
  final DateTime createdAt;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt,
  });

  NotificationItem copyWith({
    int? id,
    String? title,
    String? message,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props => [id, title, message, isRead, createdAt];


   

}