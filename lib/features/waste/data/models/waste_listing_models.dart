
import 'package:trash2cash/features/waste/domain/entities/waste_listing.dart';

class WasteListingModel extends WasteListing {
  const WasteListingModel({
    required super.id,
    required super.title,
    required super.description,
    required super.pickupLocation,
    required super.type,
    required super.unit,
    required super.weight,
    required super.contactPhone,
    required super.imageUrl,
    required super.time
    
  });

  factory WasteListingModel.fromJson(Map<String, dynamic> json) {
    return WasteListingModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      pickupLocation: json['pickupLocation'] as String,
      // Convert the string from the API to our enum
      type: _wasteTypeFromString(json['type'] as String),
      unit: (json['unit'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      contactPhone: json['contactPhone'] as String,
      imageUrl: json['imageUrl'] as String,
      time: json['time'] as String
    );
  }

  // Helper function to safely convert the string to our enum
  // static Type _wasteTypeFromString(String roleString) {
  //   return Type.values.firstWhere(
  //     (type) => type.name == roleString,
  //     orElse: () => Type.PLASTIC, // Provide a sensible default
  //   );
  // }

  static Type _wasteTypeFromString(String typeString) {
    print("Attempting to parse waste type: $typeString");
    return Type.values.firstWhere(
      (type) => type.name == typeString,
      // Instead of defaulting, throw an error so we can see it.
      orElse: () => Type.PLASTIC
    );
  }
}