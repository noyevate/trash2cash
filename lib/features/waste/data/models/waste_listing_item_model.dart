
import 'package:trash2cash/features/waste/domain/entities/waste_listing_items.dart';

class WasteListingItemModel extends WasteListingItem {
  const WasteListingItemModel({
    super.id,
    super.title,
     super.description,
     super.pickupLocation,
     super.type,
     required super.unit,
     required super.weight,
     super.contactPhone,
     super.imageUrl,
    super.status,
    super.time,
    super.createdBy,
  });

  factory WasteListingItemModel.fromJson(Map<String, dynamic> json) {
    return WasteListingItemModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      pickupLocation: json['pickupLocation'] as String?,
      type: json['type'] == null ? null :  json['type'] as String?,
      unit: (json['unit'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      contactPhone: json['contactPhone'] as String?,
      imageUrl: json['imageUrl'] as String?,
      status: json['status'], // This will be null if not present
      createdBy: json['createdBy'] as int?,
      time: json['time'] == null ? null : DateTime.tryParse(json['time']),
    );
  }
}