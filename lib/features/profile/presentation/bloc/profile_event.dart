part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class GetProfileRequested extends ProfileEvent {}

class UpdateProfileRequested extends ProfileEvent {
  final String firstName;
  final String location;
  final String phone;
  final File? image;

  const UpdateProfileRequested({
    required this.firstName,
    required this.location,
    required this.phone,
    this.image,
  });
}