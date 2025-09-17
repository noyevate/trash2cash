import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  final double balance;
  final int points;

  const Wallet({required this.balance, required this.points});

  @override
  List<Object> get props => [balance, points];
}