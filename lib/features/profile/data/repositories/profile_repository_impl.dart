

import 'dart:io';

import 'package:trash2cash/core/error/exceptions.dart';
import 'package:trash2cash/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:trash2cash/features/profile/domain/entities/user_profile.dart';
import 'package:trash2cash/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserProfile> getUserProfile() {
    try {
      // The model is compatible with the entity, so we can return it directly.
      return remoteDataSource.getUserProfile(); 
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<UserProfile> updateUserProfile({
    required String firstName,
    required String location,
    required String phone,
    File? image,
  }) {
    try {
      return remoteDataSource.updateUserProfile(
        firstName: firstName,
        location: location,
        phone: phone,
        image: image,
      );
    } on ServerException {
      rethrow;
    }
  }
}