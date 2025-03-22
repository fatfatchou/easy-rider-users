import 'package:users/features/home/domain/entities/location_entity.dart';
import 'package:users/features/search/domain/entities/suggestion_place_entity.dart';

abstract class SearchRepository {
  Future<List<SuggestionPlaceEntity>> getAutomaticallySuggestion({
    required String query,
    required double longitude,
    required double latitude,
    required String sessionToken,
  });

  Future<LocationEntity> getDropoffLocation({
    required String mapboxId,
    required String sessionToken,
  });
}
