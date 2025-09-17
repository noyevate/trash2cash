
// An enum for the activity type
import 'package:equatable/equatable.dart';

enum ActivityType {
  PAID,
  SCHEDULED,
  COMPLETED,
  ALL, // We'll use this for the "All" tab
  UNKNOWN, // Fallback for safety
}

// An abstract class for the polymorphic 'details'
abstract class ActivityDetails extends Equatable {
  const ActivityDetails();
}

// A concrete class for 'PAID' details
class PaidActivityDetails extends ActivityDetails {
  final double amount;
  final String listingTitle;
  final int transactionId;

  const PaidActivityDetails({
    required this.amount,
    required this.listingTitle,
    required this.transactionId,
  });

  @override
  List<Object> get props => [amount, listingTitle, transactionId];
}

// A concrete class for 'SCHEDULED' details
class ScheduledActivityDetails extends ActivityDetails {
  final String listingTitle;
  final int listingId;
  final DateTime scheduledDateTime;
  final String recycler;
  
  const ScheduledActivityDetails({
    required this.listingTitle,
    required this.listingId,
    required this.scheduledDateTime,
    required this.recycler,
  });

  @override
  List<Object> get props => [listingTitle, listingId, scheduledDateTime, recycler];
}

// A concrete class for 'COMPLETED' details
class CompletedActivityDetails extends ActivityDetails {
  final String recycler;
  final String listingTitle;
  final int listingId;

  const CompletedActivityDetails({
    required this.recycler,
    required this.listingTitle,
    required this.listingId,
  });

  @override
  List<Object> get props => [recycler, listingTitle, listingId];
}

// The main Activity entity
class ActivityItem extends Equatable {
  final ActivityType type;
  final String title;
  final String description;
  final ActivityDetails details;
  final DateTime timestamp;

  const ActivityItem({
    required this.type,
    required this.title,
    required this.description,
    required this.details,
    required this.timestamp,
  });

  @override
  List<Object> get props => [type, title, description, details, timestamp];
}