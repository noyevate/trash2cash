import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  final int id;
  final double balance;
  final int points;
  final DateTime updatedAt;

  const Wallet({
    required this.id,
    required this.balance,
    required this.points,
    required this.updatedAt,
  });

  @override
  List<Object> get props => [id, balance, points, updatedAt];
}