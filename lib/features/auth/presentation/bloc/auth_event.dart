
// import 'package:equatable/equatable.dart';

part of 'auth_bloc.dart';


abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class AuthRegisterRequested extends AuthEvent {
  final String email;
  final String firstName;
  final String password;
  const AuthRegisterRequested(this.email, this.firstName, this.password);
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  const AuthLoginRequested(this.email, this.password);
}