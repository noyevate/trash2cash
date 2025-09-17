import 'package:trash2cash/features/profile/domain/repositories/profile_repository.dart';

import '../entities/user_profile.dart';

class GetUserProfile {
  final ProfileRepository repository;

  GetUserProfile(this.repository);

  Future<UserProfile> call() {
    return repository.getUserProfile();
  }
}