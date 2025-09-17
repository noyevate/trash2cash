part of 'user_role_bloc.dart';


abstract class UserRoleEvent extends Equatable {
  const UserRoleEvent();
  @override
  List<Object> get props => [];
}

class UserRoleSelected extends UserRoleEvent {
  final UserRole role;
  const UserRoleSelected(this.role);
}