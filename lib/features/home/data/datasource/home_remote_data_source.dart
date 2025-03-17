import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:users/features/home/data/models/location_model.dart';

class HomeRemoteDataSource {
  final String baseUrl;

  HomeRemoteDataSource({required this.baseUrl});

  Future<String> getAddressFromCoordinates(
      {required Position position}) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/search/geocode/v6/reverse?longitude=${position.longitude}&latitude=${position.latitude}&access_token=${dotenv.env['MAPBOX_ACCESS_TOKEN']}'),
    );

    print("Reponse: ${response.body}");

    if (response.statusCode == 200) {
      return LocationModel.fromJson(
          jsonDecode(response.body)['features'][0]).locationName;
    } else {
      throw Exception('Failed to fetch Profile');
    }
  }
}
