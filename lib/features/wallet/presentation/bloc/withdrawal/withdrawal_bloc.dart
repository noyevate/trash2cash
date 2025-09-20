import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash2cash/features/wallet/domain/usecases/withdraw_funds.dart';

part 'withdrawal_event.dart';
part 'withdrawal_state.dart';

class WithdrawalBloc extends Bloc<WithdrawalEvent, WithdrawalState> {
  final WithdrawFunds _withdrawFunds;

  WithdrawalBloc({required WithdrawFunds withdrawFunds})
      : _withdrawFunds = withdrawFunds,
        super(WithdrawalInitial()) {
    on<WithdrawalRequested>(_onWithdrawalRequested);
  }

  Future<void> _onWithdrawalRequested(
    WithdrawalRequested event, Emitter<WithdrawalState> emit) async {
    emit(WithdrawalInProgress());
    try {
      await _withdrawFunds(
        amount: event.amount,
        bankCode: event.bankCode,
        accountNumber: event.accountNumber,
      );
      emit(WithdrawalSuccess());
    } catch (e) {
      emit(WithdrawalFailure(e.toString()));
    }
  }
}