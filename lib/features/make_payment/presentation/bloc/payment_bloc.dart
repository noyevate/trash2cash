import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash2cash/features/make_payment/domain/usecases/accept_wast_listing.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final AcceptWasteListing _acceptWasteListing;

  PaymentBloc({required AcceptWasteListing acceptWasteListing})
      : _acceptWasteListing = acceptWasteListing,
        super(PaymentInitial()) {
    on<AcceptListingRequested>(_onAcceptListingRequested);
  }

  Future<void> _onAcceptListingRequested(
    AcceptListingRequested event, Emitter<PaymentState> emit) async {
    emit(PaymentInProgress());
    try {
      await _acceptWasteListing(event.listingId);
      emit(PaymentSuccess());
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }
}