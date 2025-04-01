import 'package:users/features/home/domain/entities/location_entity.dart';

abstract class HomeEvent {}

class GetUserLocationEvent extends HomeEvent {}

class InitializeGeofireListenerEvent extends HomeEvent {
  final LocationEntity userLocation;
  final bool activeNearbyDriverKeysLoaded;

  InitializeGeofireListenerEvent({
    required this.userLocation,
    required this.activeNearbyDriverKeysLoaded,
  });
}

class UpdateDropoffLocationEvent extends HomeEvent {
  final LocationEntity dropoffLocation;

  UpdateDropoffLocationEvent({required this.dropoffLocation});
}

class GetPolylineEvent extends HomeEvent {
  final LocationEntity originLocation;
  final LocationEntity dropoffLocation;

  GetPolylineEvent(
      {required this.originLocation, required this.dropoffLocation});
}
