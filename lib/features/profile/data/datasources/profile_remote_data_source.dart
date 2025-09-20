import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:trash2cash/constants/others.dart';
import 'package:trash2cash/core/error/exceptions.dart';
import 'package:trash2cash/features/profile/data/model/user_profile_model.dart';

// 

// --- THE CORRECTED CONTRACT ---
abstract class ProfileRemoteDataSource {
  Future<UserProfileModel> getUserProfile();
  Future<UserProfileModel> updateUserProfile({
    required String firstName,
    required String phone,
    required String location,
    File? image,
  });
}


class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final http.Client client;
  final GetStorage box;

  ProfileRemoteDataSourceImpl({required this.client, required this.box});

  @override
  Future<UserProfileModel> getUserProfile() async {
    final token = box.read('accessToken');
    if (token == null) {
      throw ServerException('Not authenticated. No token found.');
    }

    final url = Uri.parse("$appBaseUrl/users/me");
    
    try {
      final response = await client.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        print("profile: ${response.body}");
        UserProfileModel userProfile = UserProfileModel.fromJson(jsonDecode(response.body));
        box.write("role", userProfile.role?.name);
        box.write('imageUrl', userProfile.imageUrl);
        return userProfile;
      } else {
        print("failed to load profile: ${response.body}");
        throw ServerException('Failed to load profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('An unexpected error occurred: ${e.toString()}');
    }
  }

  // --- THE IMPLEMENTATION (WHICH WAS ALREADY CORRECT) ---
  @override
Future<UserProfileModel> updateUserProfile({
  required String firstName,
  required String phone,
  required String location,
  File? image,
}) async {
  final token = box.read('accessToken');
  if (token == null) throw ServerException('Not authenticated.');

  final url = Uri.parse("$appBaseUrl/users/me/profile");
  
  try {
    var request = http.MultipartRequest('PUT', url);

    request.headers.addAll({"Authorization": "Bearer $token"});

    final Map<String, dynamic> jsonData = {
      'firstName': firstName,
      'location': location,
      'phone': phone,
    };

    
    request.fields['data'] = jsonEncode(jsonData);

   
    if (image != null) {
      var multipartFile = await http.MultipartFile.fromPath('file', image.path);
      request.files.add(multipartFile);
    }
    var streamedResponse = await client.send(request);
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print("update profile success: ${response.body}");
      final userprof = UserProfileModel.fromJson(jsonDecode(response.body));
      box.write("imageUrl", userprof.imageUrl);
      return UserProfileModel.fromJson(jsonDecode(response.body));
    } else {
      print("update profile failure: ${response.body}");
      print("update profile statusCode: ${response.statusCode}");
      throw ServerException('Failed to update profile. Status: ${response.statusCode}, Body: ${response.body}');
    }
  } catch (e) {
    throw ServerException('An unexpected error occurred: ${e.toString()}');
  }
}
}