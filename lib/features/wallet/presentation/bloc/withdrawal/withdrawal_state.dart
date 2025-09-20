part of 'withdrawal_bloc.dart';

abstract class WithdrawalState extends Equatable {
  const WithdrawalState();
  @override
  List<Object> get props => [];
}

class WithdrawalInitial extends WithdrawalState {}
class WithdrawalInProgress extends WithdrawalState {}
class WithdrawalSuccess extends WithdrawalState {}
class WithdrawalFailure extends WithdrawalState {
  final String error;
  const WithdrawalFailure(this.error);
}