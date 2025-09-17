import '../entities/auth_user.dart';

abstract class AuthRepository {
   Future<void> register({required String email, required String firstName, required String password});
  Future<AuthUser> login({required String email, required String password});
 
}