abstract class SearchEvent {}

class GetAutomaticallySuggestionEvent extends SearchEvent {
  final String query;
  final double longitude;
  final double latitude;

  GetAutomaticallySuggestionEvent({
    required this.query,
    required this.longitude,
    required this.latitude,
  });
}

class GetDropoffLocationEvent extends SearchEvent {
  final String mapboxId;
  final String sessionToken;

  GetDropoffLocationEvent({required this.mapboxId, required this.sessionToken});
}