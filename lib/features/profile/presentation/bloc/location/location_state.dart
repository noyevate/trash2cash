

part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoadInProgress extends LocationState {}

class LocationLoadSuccess extends LocationState {
  final String address;
  const LocationLoadSuccess(this.address);
  @override
  List<Object> get props => [address];
}

class LocationLoadFailure extends LocationState {
  final String error;

  const LocationLoadFailure(this.error);

  @override
  List<Object> get props => [error];

}

