import 'package:trash2cash/features/wallet/domain/repositories/wallet_repositories.dart';

import '../entities/wallet.dart';

class GetWalletDetails {
  final WalletRepository repository;

  GetWalletDetails(this.repository);

  Future<Wallet> call() {
    return repository.getWalletDetails();
  }
}