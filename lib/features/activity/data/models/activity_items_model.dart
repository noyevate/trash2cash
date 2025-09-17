
// Helper function to convert string to enum, outside the class
import 'package:trash2cash/features/activity/domain/entities/activity_item.dart';

ActivityType _activityTypeFromString(String typeString) {
  return ActivityType.values.firstWhere(
    (type) => type.name == typeString,
    orElse: () => ActivityType.UNKNOWN,
  );
}

// Model for the main item
class ActivityItemModel extends ActivityItem {
  const ActivityItemModel({
    required super.type,
    required super.title,
    required super.description,
    required super.details,
    required super.timestamp,
  });

  factory ActivityItemModel.fromJson(Map<String, dynamic> json) {
    final type = _activityTypeFromString(json['type'] as String);
    return ActivityItemModel(
      type: type,
      title: json['title'] as String,
      description: json['description'] as String,
      details: _detailsFromJson(type, json['details']), // Use helper for details
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  // Polymorphic factory for details
  static ActivityDetails _detailsFromJson(ActivityType type, Map<String, dynamic> json) {
    switch (type) {
      case ActivityType.PAID:
        return PaidActivityDetailsModel.fromJson(json);
      case ActivityType.SCHEDULED:
        return ScheduledActivityDetailsModel.fromJson(json);
      case ActivityType.COMPLETED:
        return CompletedActivityDetailsModel.fromJson(json);
      default:
        // You can return a default empty details object or throw an error
        return const PaidActivityDetails(amount: 0, listingTitle: 'Unknown', transactionId: 0);
    }
  }
}

// --- Concrete Models for each 'details' type ---

class PaidActivityDetailsModel extends PaidActivityDetails {
  const PaidActivityDetailsModel({
    required super.amount,
    required super.listingTitle,
    required super.transactionId,
  });
  factory PaidActivityDetailsModel.fromJson(Map<String, dynamic> json) {
    return PaidActivityDetailsModel(
      amount: (json['amount'] as num).toDouble(),
      listingTitle: json['listingTitle'] as String,
      transactionId: json['transactionId'] as int,
    );
  }
}

class ScheduledActivityDetailsModel extends ScheduledActivityDetails {
  const ScheduledActivityDetailsModel({
    required super.listingTitle,
    required super.listingId,
    required super.scheduledDateTime,
    required super.recycler,
  });
  factory ScheduledActivityDetailsModel.fromJson(Map<String, dynamic> json) {
    return ScheduledActivityDetailsModel(
      listingTitle: json['listingTitle'] as String,
      listingId: json['listingId'] as int,
      scheduledDateTime: DateTime.parse(json['scheduledDateTime'] as String),
      recycler: json['recycler'] as String,
    );
  }
}

class CompletedActivityDetailsModel extends CompletedActivityDetails {
  const CompletedActivityDetailsModel({
    required super.listingTitle,
    required super.listingId,
    required super.recycler,
  });
  factory CompletedActivityDetailsModel.fromJson(Map<String, dynamic> json) {
    return CompletedActivityDetailsModel(
      listingTitle: json['listingTitle'] as String,
      listingId: json['listingId'] as int,
      recycler: json['recycler'] as String,
    );
  }
}

