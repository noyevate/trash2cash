// import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<void> call({required String email, required String firstName, required String password}) {
    return repository.register(email: email, firstName: firstName, password: password);
  }
}