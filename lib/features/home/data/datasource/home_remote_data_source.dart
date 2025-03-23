import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:users/features/home/data/models/direction_model.dart';
import 'package:users/features/home/data/models/location_model.dart';
import 'package:users/features/home/domain/entities/location_entity.dart';

class HomeRemoteDataSource {
  final String baseUrl;

  HomeRemoteDataSource({required this.baseUrl});

  Future<String> getAddressFromCoordinates({required Position position}) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/search/geocode/v6/reverse?longitude=${position.longitude}&latitude=${position.latitude}&access_token=${dotenv.env['MAPBOX_ACCESS_TOKEN']}'),
    );

    if (response.statusCode == 200) {
      return LocationModel.fromJson(jsonDecode(response.body)['features'][0])
          .locationName;
    } else {
      throw Exception('Failed to fetch Profile');
    }
  }

  Future<DirectionModel> getPolyline(
      {required LocationEntity originLocation,
      required LocationEntity dropoffLocation}) async {
    const String profile = 'mapbox/driving';
    final String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN']!;

    final response = await http.get(
      Uri.parse(
        '$baseUrl/directions/v5/'
        '$profile/'
        '${originLocation.longitude},${originLocation.latitude};'
        '${dropoffLocation.longitude},${dropoffLocation.latitude}'
        '?overview=full'
        '&access_token=$accessToken',
      ),
    );

    print(jsonDecode(response.body)['routes'][0]);

    if (response.statusCode == 200) {
      return DirectionModel.fromJson(jsonDecode(response.body)['routes'][0]);
    } else {
      throw Exception('Failed to fetch Profile');
    }
  }
}
