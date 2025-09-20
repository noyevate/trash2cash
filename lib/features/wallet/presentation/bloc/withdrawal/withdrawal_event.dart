part of 'withdrawal_bloc.dart';

abstract class WithdrawalEvent extends Equatable {
  const WithdrawalEvent();
  @override
  List<Object> get props => [];
}

class WithdrawalRequested extends WithdrawalEvent {
  final double amount;
  final String bankCode;
  final String accountNumber;

  const WithdrawalRequested({
    required this.amount,
    required this.bankCode,
    required this.accountNumber,
  });

  @override
  List<Object> get props => [amount, bankCode, accountNumber];
}