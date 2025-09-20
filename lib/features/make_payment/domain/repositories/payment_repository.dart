abstract class PaymentRepository {
  // We only need the ID of the listing the recycler wants to accept/buy.
  Future<void> acceptWasteListing(int listingId);
}