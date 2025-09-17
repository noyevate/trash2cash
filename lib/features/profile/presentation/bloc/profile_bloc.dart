import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trash2cash/features/profile/domain/entities/user_profile.dart';
import 'package:trash2cash/features/profile/domain/usecases/get_user_profile.dart';
import 'package:trash2cash/features/profile/domain/usecases/update_user_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfile _getUserProfile;
  final UpdateUserProfile _updateUserProfile;

  ProfileBloc({required GetUserProfile getUserProfile, required UpdateUserProfile updateUserProfile,})
      : _getUserProfile = getUserProfile,
      _updateUserProfile = updateUserProfile,
        super(ProfileInitial()) {
    on<GetProfileRequested>(_onGetProfileRequested);
    on<UpdateProfileRequested>(_onUpdateProfileRequested);
  }

  Future<void> _onGetProfileRequested(
    GetProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadInProgress());
    try {
      final userProfile = await _getUserProfile();
      emit(ProfileLoadSuccess(userProfile));
    } catch (e) {
      emit(ProfileLoadFailure(e.toString()));
    }
  }

   Future<void> _onUpdateProfileRequested(
    UpdateProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileUpdateInProgress());
    try {
      final updatedProfile = await _updateUserProfile(
        firstName: event.firstName,
        location: event.location,
        phone: event.phone,
        image: event.image,
      );
      // On success, emit the success state with the NEW profile data
      emit(ProfileLoadSuccess(updatedProfile));
    } catch (e) {
      emit(ProfileLoadFailure(e.toString()));
    }
  }
}