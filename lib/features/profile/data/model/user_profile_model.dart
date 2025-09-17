import 'package:trash2cash/features/choose_role/domain/entities/user_role.dart';
import 'package:trash2cash/features/profile/domain/entities/user_profile.dart';


class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.id,
    required super.email,
    required super.firstName,
    super.phone,
    super.imageUrl,
    super.location,
    super.role,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as int,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      phone: json['phone'],
      imageUrl: json['imageUrl'],
      location: json['location'],
      // Safely convert the role string from the API to our enum
       role: json['role'] == null ? null : _roleFromString(json['role'] as String),
    );
  }

  // Helper function to convert string to enum
  static UserRole _roleFromString(String roleString) {
    return UserRole.values.firstWhere(
      (role) => role.name == roleString,
      orElse: () => UserRole.GENERATOR, // Default fallback
    );
  }
}