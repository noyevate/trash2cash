import 'dart:io'; // Needed for the File type
import '../entities/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile> getUserProfile();
  // --- ADD THIS NEW METHOD ---
  Future<UserProfile> updateUserProfile({
    required String firstName,
    required String location,
    required String phone,
    File? image, // The image is optional
  });
}