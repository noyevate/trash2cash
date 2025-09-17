import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trash2cash/features/choose_role/domain/entities/user_role.dart';
import 'package:trash2cash/features/choose_role/domain/usecases/update_use_role.dart';


part 'user_role_event.dart';
part 'user_role_state.dart';

class UserRoleBloc extends Bloc<UserRoleEvent, UserRoleState> {
  final UpdateUserRole _updateUserRole;

  UserRoleBloc({required UpdateUserRole updateUserRole})
      : _updateUserRole = updateUserRole,
        super(UserRoleInitial()) {
    on<UserRoleSelected>(_onUserRoleSelected);
  }

  Future<void> _onUserRoleSelected(
    UserRoleSelected event,
    Emitter<UserRoleState> emit,
  ) async {
    emit(UserRoleUpdateInProgress());
    try {
      await _updateUserRole(event.role);
      emit(UserRoleUpdateSuccess(event.role));
    } catch (e) {
      emit(UserRoleUpdateFailure(e.toString()));
    }
  }
}