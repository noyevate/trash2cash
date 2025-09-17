import 'package:trash2cash/features/choose_role/domain/repositories/user_repositories.dart';

import '../entities/user_role.dart';

class UpdateUserRole {
  final UserRepository repository;

  UpdateUserRole(this.repository);

  Future<void> call(UserRole role) {
    return repository.updateUserRole(role);
  }
}