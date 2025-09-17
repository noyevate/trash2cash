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

  @override
  List<Object> get props => [id, title, message, isRead, createdAt];
}