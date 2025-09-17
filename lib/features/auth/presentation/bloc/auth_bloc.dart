import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trash2cash/features/Auth/domain/entities/auth_user.dart';
import 'package:trash2cash/features/Auth/domain/usecases/login_user.dart';
import 'package:trash2cash/features/Auth/domain/usecases/register_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUser _registerUser;
  final LoginUser _loginUser;

  AuthBloc({required RegisterUser registerUser, required LoginUser loginUser})
      : _registerUser = registerUser,
        _loginUser = loginUser,
        super(AuthInitial()) {
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLoginRequested>(_onLoginRequested);
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _registerUser(
        email: event.email,
        firstName: event.firstName,
        password: event.password,
      );
      // Emit the new state for registration
      emit(RegistrationSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // The login use case now returns the AuthUser
      final user = await _loginUser(
        email: event.email,
        password: event.password,
      );
      // Emit the Authenticated state with the user object
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}