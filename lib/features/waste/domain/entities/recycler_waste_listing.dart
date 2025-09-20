import 'package:equatable/equatable.dart';

class RecyclerWasteListing extends Equatable {
  final int? id; // <-- Make nullable
  final String? title; // <-- Make nullable
  final String? description;
  final String? pickupLocation;
  final String? type;
  final double? unit;
  final double? weight;
  final String? contactPhone;
  final String? imageUrl;
  final DateTime? time;
  final String? status;
  final int? createdBy;
  final double? amount;

  const RecyclerWasteListing({
    this.id,
    this.title,
    this.description,
    this.pickupLocation,
    this.type,
    this.unit,
    this.weight,
    this.contactPhone,
    this.imageUrl,
    this.time,
    this.status,
    this.createdBy,
    this.amount,
  });

  @override
  List<Object?> get props => [
    
        id, title, description, pickupLocation, type, unit, weight,
        contactPhone, imageUrl, time, status, createdBy, amount
      ];
}