import 'package:users/features/search/domain/entities/suggestion_place_entity.dart';

class SuggestionPlaceModel extends SuggestionPlaceEntity {
  SuggestionPlaceModel({
    required super.mapboxId,
    required super.sessionToken,
    required super.mainText,
    required super.subText,
  });

  factory SuggestionPlaceModel.fromJson(Map<String, dynamic> json, String sessionToken) {
    return SuggestionPlaceModel(
      mapboxId: json['mapbox_id'],
      sessionToken: sessionToken,
      mainText: json['name'],
      subText: json['full_address'],
    );
  }
}
