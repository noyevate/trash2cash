import '../entities/user_role.dart';

abstract class UserRepository {
  Future<void> updateUserRole(UserRole role);
}