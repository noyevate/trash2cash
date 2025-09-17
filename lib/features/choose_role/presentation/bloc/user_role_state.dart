part of 'user_role_bloc.dart';

abstract class UserRoleState extends Equatable {
  const UserRoleState();
  @override
  List<Object> get props => [];
}

class UserRoleInitial extends UserRoleState {}

class UserRoleUpdateInProgress extends UserRoleState {}

class UserRoleUpdateSuccess extends UserRoleState {
  final UserRole selectedRole;
  const UserRoleUpdateSuccess(this.selectedRole);
}

class UserRoleUpdateFailure extends UserRoleState {
  final String error;
  const UserRoleUpdateFailure(this.error);
}