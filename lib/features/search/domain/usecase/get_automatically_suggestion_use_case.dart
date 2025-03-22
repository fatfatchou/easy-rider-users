import 'package:users/features/search/domain/entities/suggestion_place_entity.dart';
import 'package:users/features/search/domain/repositories/search_repository.dart';

class GetAutomaticallySuggestionUseCase {
  final SearchRepository searchRepository;

  GetAutomaticallySuggestionUseCase({required this.searchRepository});

  Future<List<SuggestionPlaceEntity>> call({
    required String query,
    required double longitude,
    required double latitude,
    required String sessionToken
  }) {
    return searchRepository.getAutomaticallySuggestion(
      query: query,
      longitude: longitude,
      latitude: latitude,
      sessionToken: sessionToken,
    );
  }
}
