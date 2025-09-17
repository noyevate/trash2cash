import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:trash2cash/constants/others.dart';
import 'package:trash2cash/core/error/exceptions.dart';
import 'package:trash2cash/features/notification/data/models/notification_item_model.dart';

// --- The Contract ---
abstract class NotificationRemoteDataSource {
  Future<List<NotificationItemModel>> getNotifications();
}

// --- The Implementation ---
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final http.Client client;
  final GetStorage box;

  NotificationRemoteDataSourceImpl({required this.client, required this.box});

  @override
  Future<List<NotificationItemModel>> getNotifications() async {
    final token = box.read('accessToken');
    if (token == null) {
      throw ServerException('Not authenticated. No token found.');
    }

    final url = Uri.parse("$appBaseUrl/notifications");
    
    print("Fetching notifications from: $url"); // For debugging

    try {
      final response = await client.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> contentList = data['content'];
        return contentList.map((json) => NotificationItemModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load notifications. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('An unexpected error occurred: ${e.toString()}');
    }
  }
}