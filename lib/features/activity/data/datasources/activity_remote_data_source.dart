import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:trash2cash/constants/others.dart';
import 'package:trash2cash/core/error/exceptions.dart';
import 'package:trash2cash/features/activity/data/models/activity_items_model.dart';
import 'package:trash2cash/features/activity/domain/entities/activity_item.dart';
import 'package:http/http.dart' as http;

abstract class ActivityRemoteDataSource {
  Future<List<ActivityItemModel>> getActivities(ActivityType type);
}

// --- The Implementation ---
class ActivityRemoteDataSourceImpl implements ActivityRemoteDataSource {
  final http.Client client;
  final GetStorage box;

  ActivityRemoteDataSourceImpl({required this.client, required this.box});

  @override
  Future<List<ActivityItemModel>> getActivities(ActivityType type) async {
    final token = box.read('accessToken');
    if (token == null) {
      throw ServerException('Not authenticated. No token found.');
    }

    // If 'ALL' is selected, we hit the endpoint without a type.
    // Otherwise, we append the type name (e.g., "PAID", "SCHEDULED").
    final endpoint = type == ActivityType.ALL ? '/activities/ALL' : '/activities/${type.name}';
    final url = Uri.parse("$appBaseUrl$endpoint");
    
    print("Fetching activities from: $url"); // For debugging

    try {
      final response = await client.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print("activities token: ${token}");
      print("activities: ${response.body}");
      if (response.statusCode == 200) {
        print("activities: ${response.body}");
        // 1. Decode the full JSON response which is a Map
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        // 2. Extract the 'content' key, which contains the list
        final List<dynamic> contentList = data['content'];
        
        // 3. Map each item in the list to our ActivityItemModel
        return contentList.map((json) => ActivityItemModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load activities. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('An unexpected error occurred: ${e.toString()}');
    }
  }
}