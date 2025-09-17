import 'package:get_storage/get_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheTokens({required String accessToken, required String refreshToken});
  Future<void> cacheUser(Map<String, dynamic> userJson);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  // ...
  final box = GetStorage();
  @override
  Future<void> cacheTokens({required String accessToken, required String refreshToken}) async {
    await box.write('accessToken', accessToken);
    await box.write('refreshToken', refreshToken);
  }

  @override
  Future<void> cacheUser(Map<String, dynamic> userJson) async {
    // We can just save the user-related parts from the login response
    await box.write('userId', userJson['id']);
    await box.write('firstName', userJson['firstName']);
    await box.write('walletBalance', userJson['walletBalance']);
    await box.write('points', userJson['points']);
    
  }
}