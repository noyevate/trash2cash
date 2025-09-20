import 'package:trash2cash/features/waste/domain/entities/recycler_waste_listing.dart';

class RecyclerWasteListingModel extends RecyclerWasteListing {
  const RecyclerWasteListingModel(
      { super.id,
       super.title,
       super.description,
       super.pickupLocation,
       super.type,
       super.unit,
       super.weight,
       super.contactPhone,
       super.imageUrl,
       super.time,
       super.status,
       super.createdBy,
       super.amount});

  factory RecyclerWasteListingModel.fromJson(Map<String, dynamic> json) {
    return RecyclerWasteListingModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      pickupLocation: json['pickupLocation'] as String?,
      type: json['type'] as String?,
      unit: (json['unit'] as num?)?.toDouble() ?? 0.0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      contactPhone: json['contactPhone'] as String?,
      imageUrl: json['imageUrl'] as String?,
      time: json['time'] == null ? null : DateTime.tryParse(json['time']),
      status: json['status'] as String?,
      createdBy: json['createdBy'] as int?,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
