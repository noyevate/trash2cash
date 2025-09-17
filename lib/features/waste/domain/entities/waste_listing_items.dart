
import 'package:equatable/equatable.dart';

class WasteListingItem extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? pickupLocation;
  final String? type;
  final double unit;
  final double weight;
  final String? contactPhone;
  final String? imageUrl;
  final String? status; // Nullable
   final DateTime? time; // <-- Add nullable time
  final int? createdBy;
  // You can add the other fields here if you need them in the UI
  // final int? generatorId;
  // final DateTime? createdAt;

  const WasteListingItem({
     this.id,
     this.title,
     this.description,
     this.pickupLocation,
     this.type,
     required this.unit,
     required this.weight,
     this.contactPhone,
     this.imageUrl,
    this.status,
    this.time,
    this.createdBy,
  });

  @override
  List<Object?> get props => [id, title, description, pickupLocation, type, unit, weight, contactPhone, imageUrl, status, time, createdBy];
}

extension WasteListingItemX on WasteListingItem {
  /// Returns a user-friendly, formatted string for the status.
  String get formattedStatus {
    // If status is null, return a default value.
    if (status == null) {
      return "Available";
    }

    // Use a switch statement to handle each case.
    switch (status) {
      case 'OPEN':
        return 'Open';
      case 'NEGOTIATION':
        return 'In Negotiation'; // More readable than "Negotiation"
      case 'PAID':
        return 'Paid';
      case 'PICKED_UP':
        return 'Picked Up'; // More readable
      case 'COMPLETED':
        return 'Completed';
      case 'SCHEDULED':
        return 'Scheduled';
      default:
        // Return a sensible default if the status is an unknown string.
        return 'Available';
    }
  }
}