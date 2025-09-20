part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

// Event dispatched from the UI when the wallet details need to be fetched or refreshed.
class FetchWalletDetails extends WalletEvent {}
