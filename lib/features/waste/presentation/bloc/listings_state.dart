part of 'listings_bloc.dart';

abstract class ListingsState extends Equatable {
  const ListingsState();
  @override
  List<Object> get props => [];
}

class ListingsInitial extends ListingsState {}

class ListingsLoadInProgress extends ListingsState {}

class ListingsLoadSuccess extends ListingsState {
  final List<WasteListingItem> listings;
  const ListingsLoadSuccess(this.listings);
}

class ListingsLoadFailure extends ListingsState {
  final String error;
  const ListingsLoadFailure(this.error);
}