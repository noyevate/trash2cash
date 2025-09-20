import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:trash2cash/constants/others.dart';
import 'package:trash2cash/core/error/exceptions.dart';


abstract class ScheduleRemoteDataSource {
  Future<void> createSchedule({
    required int listingId,
    required String pickupLocation,
    required String pickupDate, // The API wants strings
    required String pickupTime,
    String? additionalNotes,
  });
}

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final http.Client client;
  final GetStorage box;

  ScheduleRemoteDataSourceImpl({required this.client, required this.box});

  @override
  Future<void> createSchedule({
    required int listingId,
    required String pickupLocation,
    required String pickupDate,
    required String pickupTime,
    String? additionalNotes,
  }) async {
    final token = box.read('accessToken');
    if (token == null) throw ServerException('Not authenticated.');

    final url = Uri.parse("$appBaseUrl/scheduler/confirm");
    
    try {
      final response = await client.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "listingId": listingId,
          "pickupLocation": pickupLocation,
          "pickupDate": pickupDate,
          "pickupTime": pickupTime,
          "additionalNotes": additionalNotes,
        }),
      );

      // final req_body = jsonEncode({
      //     "listingId": listingId,
      //     "pickupLocation": pickupLocation,
      //     "pickupDate": pickupDate,
      //     "pickupTime": pickupTime,
      //     "additionalNotes": additionalNotes,
      //   });

      print('schedule: ${response.body}');
      print('schedule statusCode: ${response.statusCode}');
      print('tokn: ${token}');
      print('schedule url: ${url}');

   
      // print(req_body);

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw ServerException('Failed to create schedule. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}