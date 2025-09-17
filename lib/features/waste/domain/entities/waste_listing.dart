import 'package:equatable/equatable.dart';

// The enum remains the same
enum Type {
  PLASTIC,
  METAL,
}

class WasteListing extends Equatable {
  final int id;
  final String title;
  final String description;
  final String pickupLocation;
  final Type type; // <-- Use the enum for type safety
  final double unit; // API docs say unit is int
  final double weight;
  final String contactPhone;
  final String imageUrl;
  final String time;

  const WasteListing({
    required this.id,
    required this.title,
    required this.description,
    required this.pickupLocation,
    required this.type,
    required this.unit,
    required this.weight,
    required this.contactPhone,
    required this.imageUrl,
    required this.time
  });

  @override
  List<Object> get props => [
        id,
        title,
        description,
        pickupLocation,
        type,
        unit,
        weight,
        contactPhone,
        imageUrl,
      ];
}