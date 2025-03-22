import 'package:users/features/home/domain/entities/location_entity.dart';
import 'package:users/features/search/data/datasource/search_remote_data_source.dart';
import 'package:users/features/search/domain/entities/suggestion_place_entity.dart';
import 'package:users/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource searchRemoteDataSource;

  SearchRepositoryImpl({required this.searchRemoteDataSource});

  @override
  Future<List<SuggestionPlaceEntity>> getAutomaticallySuggestion({
    required String query,
    required double longitude,
    required double latitude,
    required String sessionToken,
  }) async {
    return await searchRemoteDataSource.getAutomaticallySuggestion(
      query: query,
      longitude: longitude,
      latitude: latitude,
      sessionToken: sessionToken,
    );
  }

  @override
  Future<LocationEntity> getDropoffLocation({
    required String mapboxId,
    required String sessionToken,
  }) async {
    return await searchRemoteDataSource.getDropoffLocation(
      mapboxId: mapboxId,
      sessionToken: sessionToken,
    );
  }
}
