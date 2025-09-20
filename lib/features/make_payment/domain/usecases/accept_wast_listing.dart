
import 'package:trash2cash/features/make_payment/domain/repositories/payment_repository.dart';

class AcceptWasteListing {
  final PaymentRepository repository;

  AcceptWasteListing(this.repository);

  Future<void> call(int listingId) {
    return repository.acceptWasteListing(listingId);
  }
}