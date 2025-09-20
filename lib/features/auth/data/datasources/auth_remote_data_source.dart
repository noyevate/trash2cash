import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:trash2cash/constants/others.dart';
import 'package:trash2cash/features/auth/data/model/login_response_model.dart';
import 'package:trash2cash/features/auth/data/model/register_response_model.dart';
import '../../../../core/error/exceptions.dart'; // Adjust path as needed

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> loginWithEmail({required String email, required String password});
  Future<RegisterResponseModel> registerWithEmail({required String email, required String firstName, required String password});
}

final box = GetStorage();
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<RegisterResponseModel> registerWithEmail({required String email, required String firstName, required String password}) async {

    print("AuthRepositoryImpl: Register method called.");

    final url = Uri.parse("$appBaseUrl/auth/register");
    try {
      final response = await client.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email, "password": password, "firstName": firstName}),
      );

      print("register statusCode: ${response.statusCode}");
      print("register: ${response.body}");
      print("register: ${url}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        await box.write('firstName', firstName);
        await box.write('email', email);
        await box.write('isLoggedIn', true);
        print(response.body);
        return RegisterResponseModel.fromJson(jsonDecode(response.body));
      } else {
        final errorBody = jsonDecode(response.body);
        print(errorBody);
        throw ServerException(errorBody['message'] ?? 'Registration failed');
      }
    } on ServerException catch (e) {
    // This is for errors returned by your server (e.g., status code 400)
    print("AuthRepositoryImpl: Caught a ServerException: ${e.message}");
    rethrow;
  } catch (e) {
      throw ServerException('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<LoginResponseModel> loginWithEmail({required String email, required String password}) async {
    final url = Uri.parse("$appBaseUrl/auth/login");
    try {
      final response = await client.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email, "password": password}),
      );

      print("register statusCode: ${response.statusCode}");
      print("register: ${response.body}");
      print("register: ${url}");

      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(response.body);
         await box.write('email', email);
        LoginResponseModel loginDetails =   LoginResponseModel.fromJson(jsonDecode(response.body));
        box.write("accessToken", loginDetails.accessToken);
        box.write('refreshToken', loginDetails.refreshToken);
        box.write('isLoggedIn', true);

        return loginDetails;

      } else {
        final errorBody = jsonDecode(response.body);
        print(errorBody);
        throw ServerException(errorBody['message'] ?? 'Invalid credentials');
      }
    } catch (e) {
      throw ServerException('An unexpected error occurred: ${e.toString()}');
    }
  }
}