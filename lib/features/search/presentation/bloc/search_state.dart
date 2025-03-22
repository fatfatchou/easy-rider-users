import 'package:users/features/home/domain/entities/location_entity.dart';
import 'package:users/features/search/domain/entities/suggestion_place_entity.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class GetAutomaticallySuggestionLoadingState extends SearchState {}

class GetAutomaticallySuggestionLoadedState extends SearchState {
  final List<SuggestionPlaceEntity> suggestionPlaces;

  GetAutomaticallySuggestionLoadedState({
    required this.suggestionPlaces,
  });
}

class GetAutomaticallySuggestionErrorState extends SearchState {
  final String message;

  GetAutomaticallySuggestionErrorState({required this.message});
}

class GetDropoffLocationLoadingState extends SearchState {}

class GetDropoffLocationLoadedState extends SearchState {
  final LocationEntity dropoffLocation;

  GetDropoffLocationLoadedState({required this.dropoffLocation});
}

class GetDropoffLocationErrorState extends SearchState {
  final String message;

  GetDropoffLocationErrorState({required this.message});
}
