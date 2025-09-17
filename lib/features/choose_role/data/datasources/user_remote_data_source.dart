import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:trash2cash/constants/others.dart';
import 'package:trash2cash/core/error/exceptions.dart';
import 'package:trash2cash/features/choose_role/domain/entities/user_role.dart';

final box = GetStorage();
abstract class UserRemoteDataSource {
  Future<void> updateUserRole(UserRole role);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<void> updateUserRole(UserRole role) async {
    // This is a good place to get the auth token from local storage
    final token = box.read('accessToken');
    print("tokrn: $token");

    // The endpoint might be something like '/users/role' or '/profile/role'
    final url = Uri.parse("$appBaseUrl/auth/assign-role"); 
    
    try {
      print(role.name);

      final requestBody = jsonEncode({'role': role.name});
final headers = {
  "Content-Type": "application/json",
  "Authorization": "Bearer $token",
};
print("--- SENDING REQUEST ---");
print("URL: $url");
print("METHOD: POST");
print("HEADERS: $headers");
print("BODY: $requestBody");
print("-----------------------");
      
      final response = await client.post( // PATCH is often used for partial updates
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", 
        },
        body: jsonEncode({'role': role.name}), 
        
      );

      if (response.statusCode != 200) {
        print("failure response: ${response.body}");
        print("failure response statuscode: ${response.statusCode}");
        throw ServerException('Failed to update role');
      }
      print("success response: ${response.body}");
    } catch (e) {
      throw ServerException('An unexpected error occurred: ${e.toString()}');
    }
  }
}