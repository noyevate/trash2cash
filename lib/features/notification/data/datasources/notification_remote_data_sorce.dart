import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:trash2cash/constants/others.dart';
import 'package:trash2cash/core/error/exceptions.dart';
import 'package:trash2cash/features/notification/data/models/notification_item_model.dart';

// --- The Contract ---
abstract class NotificationRemoteDataSource {
  Future<List<NotificationItemModel>> getNotifications();
  Future<void> markNotificationAsRead(int notificationId);
   Future<void> markAllNotificationsAsRead();
   Future<int> getUnreadNotificationCount();
 
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

    final url = Uri.parse("$appBaseUrl/notifications/all");
    
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

   @override
  Future<void> markNotificationAsRead(int notificationId) async {
    final token = box.read('accessToken');
    if (token == null) throw ServerException('Not authenticated.');

    final url = Uri.parse("$appBaseUrl/notifications/mark-read/$notificationId");
    
    try {
      final response = await client.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print("notification as read url: ${url}");
      print("notification as read: ${response.body}");
      print("notification as read statuscode: ${response.statusCode}");
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ServerException('Failed to mark notification as read. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<void> markAllNotificationsAsRead() async {
    final token = box.read('accessToken');
    if (token == null) throw ServerException('Not authenticated.');

    // The endpoint is likely something like /notifications/read-all
    final url = Uri.parse("$appBaseUrl/notifications/mark-all-read");
    
    try {
      // A PATCH or PUT request is suitable here.
      final response = await client.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("notification as mark all read url: ${url}");
      print("notification as mark all read: ${response.body}");
      print("notification as mark all read statuscode: ${response.statusCode}");
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ServerException('Failed to mark all notifications as read. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<int> getUnreadNotificationCount() async {
    final token = box.read('accessToken');
    if (token == null) throw ServerException('Not authenticated.');

    final url = Uri.parse("$appBaseUrl/notifications/unread-count");
    
    try {
      final response = await client.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("unreadNotifications url: ${url}");
      print("unreadNotifications: ${response.body}");
      print("unreadNotifications statuscode: ${response.statusCode}");

      if (response.statusCode == 200) {
        
        final data = jsonDecode(response.body);
        return data['unreadNotifications'] as int;
      } else {
        throw ServerException('Failed to get unread count. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('An unexpected error occurred: ${e.toString()}');
    }
  }
}