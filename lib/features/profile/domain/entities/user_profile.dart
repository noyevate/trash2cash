import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:trash2cash/features/choose_role/domain/entities/user_role.dart';

class UserProfile extends Equatable {
  final int id;
  final String email;
  final String firstName;
  final String? phone; // Nullable if it can be empty
  final String? imageUrl; // Nullable
  final String? location; // Nullable
  final UserRole? role;

  const UserProfile({
    required this.id,
    required this.email,
    required this.firstName,
    this.phone,
    this.imageUrl,
    this.location,
    this.role,
  });

  @override
  List<Object?> get props => [id, email, firstName, phone, imageUrl, location, role];
}


// abstract class ProfileRepository {
//   Future<UserProfile> getUserProfile();
// }

//   Future<UserProfile> updateUserProfile({
//     required String firstName,
//     required String email,
//     required String phone,
//     File? image, // The image is optional
//   });