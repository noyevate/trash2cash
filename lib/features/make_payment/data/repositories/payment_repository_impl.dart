

import 'package:trash2cash/core/error/exceptions.dart';
import 'package:trash2cash/features/make_payment/data/datasources/payment_remote_data_source.dart';
import 'package:trash2cash/features/make_payment/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> acceptWasteListing(int listingId) {
    try {
      return remoteDataSource.acceptWasteListing(listingId);
    } on ServerException {
      rethrow;
    }
  }
}