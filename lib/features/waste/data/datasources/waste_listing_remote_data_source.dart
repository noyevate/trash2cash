

import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:trash2cash/constants/others.dart';
import 'package:trash2cash/core/error/exceptions.dart';
import 'package:trash2cash/features/waste/data/models/recycler_waste_listing_model.dart';
import 'package:trash2cash/features/waste/data/models/waste_listing_item_model.dart';
import 'package:trash2cash/features/waste/data/models/waste_listing_models.dart';
import 'package:trash2cash/features/waste/domain/entities/waste_listing.dart';
import 'package:trash2cash/features/waste/domain/entities/waste_listing_items.dart';

// --- THE CORRECTED CONTRACT ---

abstract class WasteRemoteDataSource {
  Future<WasteListingModel> createWasteListing({
    required String title,
    required String description,
    required String pickupLocation,
    required Type type,
    required double unit,
    required double weight,
    required String contactPhone,
    required File image,
  });

   Future<List<WasteListingItemModel>> getWasteListings();
   Future<List<RecyclerWasteListingModel>> getAllWasteListings();
}

class WasteRemoteDataSourceImpl implements WasteRemoteDataSource {
  final http.Client client;
  final GetStorage box;

  WasteRemoteDataSourceImpl({required this.client, required this.box});

  @override
  Future<WasteListingModel> createWasteListing({
    required String title,
    required String description,
    required String pickupLocation,
    required Type type,
    required double unit,
    required double weight,
    required String contactPhone,
    required File image,
  }) async {
    final token = box.read('accessToken');
    if (token == null) throw ServerException('Not authenticated.');

    final url = Uri.parse("$appBaseUrl/listings");
    try {
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll({"Authorization": "Bearer $token"});

      final Map<String, dynamic> jsonData = {
        "title": title,
        "description": description,
        "pickupLocation": pickupLocation,
        "type": type.name, // The server log expects this to be part of the JSON
        "unit": unit,
        "weight": weight,
        "contactPhone": contactPhone,
      };

      request.fields['data'] = jsonEncode(jsonData);

      request.files.add(await http.MultipartFile.fromPath('file', image.path));
      
      // request.fields['title'] = title;
      // request.fields['description'] = description;
      // request.fields['pickupLocation'] = pickupLocation;
      
      
      // request.fields['wasteType'] = wasteType.name; 
      
      // request.fields['unit'] = unit.toString();
      // request.fields['weight'] = weight.toString();
      // request.fields['contactPhone'] = contactPhone;

      var streamedResponse = await client.send(request);
      var response = await http.Response.fromStream(streamedResponse);


      if (response.statusCode == 201 || response.statusCode == 200) {
        print("token ${token}");
        print("waste-listing-response ${response.body}");
        print("waste-listing-statuscode ${response.statusCode}");

        return WasteListingModel.fromJson(jsonDecode(response.body));
      } else {
        print("waste-listing-response ${response.body}");
        
        throw ServerException('Failed to create listing. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw ServerException('An unexpected error occurred: ${e.toString()}');
    }
  }


  @override
  Future<List<WasteListingItemModel>> getWasteListings() async {
    final token = box.read('accessToken');
    if (token == null) throw ServerException('Not authenticated.');

    final url = Uri.parse("$appBaseUrl/listings/me"); // Endpoint for getting all listings
    
    try {
      final response = await client.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        print("token ${token}");
        print("waste-listing-response ${response.body}");
        print("waste-listing-statuscode ${response.statusCode}");
        // 1. Decode the response body which is a list of JSON objects
        final List<dynamic> jsonList = jsonDecode(response.body);
        
        // 2. Map each JSON object in the list to a WasteListingModel
        return jsonList.map((json) => WasteListingItemModel.fromJson(json)).toList();
      } else {
        print("token ${token}");
        print("waste-listing-response ${response.body}");
        print("waste-listing-statuscode ${response.statusCode}");
        throw ServerException('Failed to load listings. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('An unexpected error occurred: ${e.toString()}');
    }
  }

    @override
  Future<List<RecyclerWasteListingModel>> getAllWasteListings() async {
    final token = box.read('accessToken');
    if (token == null) throw ServerException('Not authenticated.');

    // Endpoint for recyclers to get all listings
    final url = Uri.parse("$appBaseUrl/listings/open"); 
    
    try {
      final response = await client.get(
        url,
        headers: { "Authorization": "Bearer $token" },
      );

       print("token ${token}");
        print("recycler waste-listing-response ${response.body}");
        print("recycler waste-listing-statuscode ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => RecyclerWasteListingModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load all listings. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}