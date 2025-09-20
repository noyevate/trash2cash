import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:trash2cash/constants/others.dart';
import 'package:trash2cash/core/error/exceptions.dart';


abstract class PaymentRemoteDataSource {
  Future<void> acceptWasteListing(int listingId);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final http.Client client;
  final GetStorage box;

  PaymentRemoteDataSourceImpl({required this.client, required this.box});

  @override
  Future<void> acceptWasteListing(int listingId) async {
    final token = box.read('accessToken');
    if (token == null) throw ServerException('Not authenticated.');

    final url = Uri.parse("$appBaseUrl/recycler/listings/$listingId/accept");
    
    try {
      // A POST request is common for actions like this.
      final response = await client.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print('accept waste listing: ${response.body}');
      print('accept waste listing status code: ${response.statusCode}');
      print('listing Id: ${listingId}');

      // A successful action often returns a 200 OK.
      if (response.statusCode != 200) {
        throw ServerException('Failed to accept listing. Status: ${response.statusCode}');
      }
      // No data needs to be returned on success.
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}