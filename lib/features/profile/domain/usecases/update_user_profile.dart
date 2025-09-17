import 'dart:io';

import 'package:trash2cash/features/profile/domain/repositories/profile_repository.dart';

import '../entities/user_profile.dart';


class UpdateUserProfile {
  final ProfileRepository repository;

  UpdateUserProfile(this.repository);

  Future<UserProfile> call({
    required String firstName,
    required String location,
    required String phone,
    File? image,
  }) {
    return repository.updateUserProfile(
      firstName: firstName,
      location: location,
      phone: phone,
      image: image,
    );
  }
}