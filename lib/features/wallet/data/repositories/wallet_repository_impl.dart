import 'package:trash2cash/core/error/exceptions.dart';
import 'package:trash2cash/features/wallet/domain/entities/wallet.dart';
import 'package:trash2cash/features/wallet/domain/repositories/wallet_repositories.dart';
import '../datasources/wallet_remote_data_source.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;

  WalletRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Wallet> getWalletDetails() {
    // The repository's role is to orchestrate data sources. In this simple case,
    // it just calls the remote data source.
    try {
      // It calls the method on the data source. The returned WalletModel
      // is a subtype of the Wallet entity, so it can be returned directly.
      return remoteDataSource.getWalletDetails();
    } on ServerException catch (e) {
      // If the data source throws a ServerException, the repository catches it
      // and re-throws it to be handled by the BLoC layer.
      rethrow;
    } catch (e) {
      // It's good practice to have a generic catch block as well.
      throw ServerException('An unexpected error occurred in the repository: ${e.toString()}');
    }
  }

  Future<void> withdrawFunds({
    required double amount,
    required String bankCode,
    required String accountNumber,
  }) {
    try {
      return remoteDataSource.withdrawFunds(
        amount: amount,
        bankCode: bankCode,
        accountNumber: accountNumber,
      );
    } on ServerException {
      rethrow;
    }
  }
}