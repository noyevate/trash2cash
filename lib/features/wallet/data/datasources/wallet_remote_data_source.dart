import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:trash2cash/constants/others.dart';
import 'package:trash2cash/core/error/exceptions.dart';
import 'package:trash2cash/features/wallet/data/models/wallet_model.dart';


// --- The Contract ---
// This defines what any wallet remote data source MUST be able to do.
abstract class WalletRemoteDataSource {
  /// Fetches the current user's wallet details from the API.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<WalletModel> getWalletDetails();
  Future<void> withdrawFunds({
    required double amount,
    required String bankCode,
    required String accountNumber,
  });
}

// --- The Implementation ---
// This is the concrete implementation of the contract that uses the http package.
class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final http.Client client;
  final GetStorage box;

  WalletRemoteDataSourceImpl({
    required this.client,
    required this.box,
  });

  @override
  Future<WalletModel> getWalletDetails() async {
    // 1. Get the authentication token from local storage.
    final token = box.read('accessToken');
    if (token == null) {
      // If there's no token, we can't make an authenticated request.
      throw ServerException('Not authenticated. No token found.');
    }

    // 2. Construct the full URL for the API endpoint.
    final url = Uri.parse("$appBaseUrl/wallets");
    
    print("Fetching wallet details from: $url"); // For debugging

    try {
      // 3. Make the authenticated GET request.
      final response = await client.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      
      print("Wallet response body: ${response.body}"); // For debugging
      print("Wallet response status code: ${response.statusCode}"); // For debugging

      // 4. Check if the request was successful.
      if (response.statusCode == 200) {
        // If successful, parse the JSON response body using the WalletModel.
        return WalletModel.fromJson(jsonDecode(response.body));
      } else {
        // If the server returned an error, throw a ServerException.
        throw ServerException('Failed to load wallet details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Catch any other errors (e.g., network issues) and wrap them.
      throw ServerException('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<void> withdrawFunds({
    required double amount,
    required String bankCode,
    required String accountNumber,
  }) async {
    final token = box.read('accessToken');
    if (token == null) throw ServerException('Not authenticated.');

    final url = Uri.parse("$appBaseUrl/wallets/withdraw");
    
    try {
      final response = await client.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "amount": amount,
          "bankCode": bankCode,
          "accountNumber": accountNumber,
        }),
      );

      // A successful withdrawal might return 200 OK or 202 Accepted.
      if (response.statusCode != 200 && response.statusCode != 202) {
        // Try to parse a more specific error message from the backend
        final errorBody = jsonDecode(response.body);
        throw ServerException(errorBody['message'] ?? 'Withdrawal failed. Status: ${response.statusCode}');
      }
      // No data needs to be returned on success.
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}