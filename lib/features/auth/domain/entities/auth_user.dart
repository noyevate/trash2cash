import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final int id;
  final String firstName;
  final double walletBalance;
  final int points;

  const AuthUser({
    required this.id,
    required this.firstName,
    required this.walletBalance,
    required this.points,
  });

  @override
  List<Object> get props => [id, firstName, walletBalance, points];
}
