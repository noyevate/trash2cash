
import 'package:trash2cash/features/wallet/domain/repositories/wallet_repositories.dart';

class WithdrawFunds {
  final WalletRepository repository;

  WithdrawFunds(this.repository);

  Future<void> call({
    required double amount,
    required String bankCode,
    required String accountNumber,
  }) {
    return repository.withdrawFunds(
      amount: amount,
      bankCode: bankCode,
      accountNumber: accountNumber,
    );
  }
}