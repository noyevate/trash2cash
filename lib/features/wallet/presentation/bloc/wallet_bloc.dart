import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash2cash/features/wallet/domain/entities/wallet.dart';
import 'package:trash2cash/features/wallet/domain/usecases/usecases.dart';


part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetWalletDetails _getWalletDetails;

  WalletBloc({required GetWalletDetails getWalletDetails})
      : _getWalletDetails = getWalletDetails,
        super(WalletInitial()) {
    on<FetchWalletDetails>(_onFetchWalletDetails);
  }

  Future<void> _onFetchWalletDetails(
    FetchWalletDetails event,
    Emitter<WalletState> emit,
  ) async {
    // Emit the loading state first to let the UI know work is being done.
    emit(WalletLoadInProgress());
    try {
      // Call the use case to fetch the data.
      final wallet = await _getWalletDetails();
      
      // On success, emit the success state with the fetched wallet data.
      emit(WalletLoadSuccess(wallet));
    } catch (e) {
      // If any exception is caught, emit the failure state with the error message.
      emit(WalletLoadFailure(e.toString()));
    }
  }
}