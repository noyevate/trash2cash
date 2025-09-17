

import 'package:trash2cash/core/error/exceptions.dart';
import 'package:trash2cash/features/Auth/data/datasources/auth_local_data_source.dart';
import 'package:trash2cash/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:trash2cash/features/Auth/domain/entities/auth_user.dart';
import 'package:trash2cash/features/Auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.remoteDataSource, required this.localDataSource});

   @override
  Future<AuthUser> register({
    required String email,
    required String firstName,
    required String password,
  }) async {
    try {
      // 1. Call the remote data source for registration
      final response = await remoteDataSource.registerWithEmail(
          email: email, firstName: firstName, password: password);
      
      // 2. Only cache the tokens
      await localDataSource.cacheTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      return AuthUser(
        id: 0,
        firstName: "",
        walletBalance: 0.0,
        points: 0,
      );
    } on ServerException {
      rethrow;
    }
  }

  
  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Call the remote data source for login
      final response = await remoteDataSource.loginWithEmail(email: email, password: password);
      
      // 2. Cache both the tokens and the user data
      await localDataSource.cacheTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      
      // Manually create the user map to cache
      final userJson = {
        'id': response.id,
        'firstName': response.firstName,
        'walletBalance': response.walletBalance,
        'points': response.points,
      };
      await localDataSource.cacheUser(userJson);
      
      // 3. Convert the response model to a domain entity and return it
      return AuthUser(
        id: response.id,
        firstName: response.firstName,
        walletBalance: response.walletBalance,
        points: response.points,
      );
    } on ServerException {
      rethrow;
    }
  }
}