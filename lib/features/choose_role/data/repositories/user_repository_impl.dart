

import 'package:trash2cash/core/error/exceptions.dart';
import 'package:trash2cash/features/choose_role/data/datasources/user_remote_data_source.dart';
import 'package:trash2cash/features/choose_role/domain/entities/user_role.dart';
import 'package:trash2cash/features/choose_role/domain/repositories/user_repositories.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> updateUserRole(UserRole role) {
    try {
      return remoteDataSource.updateUserRole(role);
    } on ServerException {
      rethrow;
    }
  }
}