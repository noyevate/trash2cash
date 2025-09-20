import '../entities/wallet.dart';
abstract class WalletRepository {
  Future<Wallet> getWalletDetails();

  Future<void> withdrawFunds({
    required double amount,
    required String bankCode,
    required String accountNumber,
  });
}