part of 'payment_bloc.dart';
abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
  @override
  List<Object> get props => [];
}

class AcceptListingRequested extends PaymentEvent {
  final int listingId;
  const AcceptListingRequested(this.listingId);
  
}