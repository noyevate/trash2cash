part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletInitial extends WalletState {}

// The state when the API call to fetch wallet details is in progress.
// The UI should show a loading indicator.
class WalletLoadInProgress extends WalletState {}

// The state when the wallet details have been successfully fetched.
// It holds the Wallet entity to be displayed by the UI.
class WalletLoadSuccess extends WalletState {
  final Wallet wallet;

  const WalletLoadSuccess(this.wallet);

  @override
  List<Object> get props => [wallet];
}

// The state when an error occurred while fetching the wallet details.
// It holds an error message for the UI to display.
class WalletLoadFailure extends WalletState {
  final String error;

  const WalletLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}