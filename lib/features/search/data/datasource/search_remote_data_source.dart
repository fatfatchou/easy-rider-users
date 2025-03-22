import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:users/features/home/data/models/location_model.dart';
import 'package:users/features/search/data/models/suggestion_place_model.dart';
import 'package:http/http.dart' as http;

class SearchRemoteDataSource {
  final String baseUrl;

  SearchRemoteDataSource({required this.baseUrl});

  Future<List<SuggestionPlaceModel>> getAutomaticallySuggestion({
    required String query,
    required double longitude,
    required double latitude,
    required String sessionToken,
  }) async {
    final String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN']!;

    final response = await http.get(
      Uri.parse(
        '$baseUrl/search/searchbox/v1/suggest'
        '?q=$query'
        '&language=vi'
        '&limit=5'
        '&session_token=$sessionToken'
        '&proximity=$longitude,$latitude'
        '&country=VN'
        '&access_token=$accessToken',
      ),
    );

    print('Session Token: $sessionToken');

    if (response.statusCode == 200) {
      final List<dynamic> suggestions =
          jsonDecode(response.body)['suggestions'];
      return suggestions
          .map((suggestion) =>
              SuggestionPlaceModel.fromJson(suggestion, sessionToken))
          .toList();
    } else {
      throw Exception('Failed to fetch Profile');
    }
  }

  Future<LocationModel> getDropoffLocation({
    required String mapboxId,
    required String sessionToken,
  }) async {
    final String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN']!;

    final response = await http.get(
      Uri.parse(
        '$baseUrl/search/searchbox/v1/retrieve/'
        '$mapboxId'
        '?session_token=$sessionToken'
        '&access_token=$accessToken',
      ),
    );

    if (response.statusCode == 200) {
      final dropoffLocation =
          LocationModel.fromJson(jsonDecode(response.body)['features'][0]);
      return dropoffLocation;
    } else {
      throw Exception('Failed to load Location');
    }
  }
}
