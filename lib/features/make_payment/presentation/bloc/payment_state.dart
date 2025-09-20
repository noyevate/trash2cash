part of 'payment_bloc.dart';
abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}
class PaymentInProgress extends PaymentState {}
class PaymentSuccess extends PaymentState {}
class PaymentFailure extends PaymentState {
  final String error;
  const PaymentFailure(this.error);
}