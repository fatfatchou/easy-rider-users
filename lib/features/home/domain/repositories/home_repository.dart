import 'package:users/features/home/domain/entities/active_nearby_driver_entity.dart';
import 'package:users/features/home/domain/entities/direction_entity.dart';
import 'package:users/features/home/domain/entities/location_entity.dart';

abstract class HomeRepository {
  Future<LocationEntity> getUserLocation();

  Future<DirectionEntity> getPolyline({
    required LocationEntity originLocation,
    required LocationEntity dropoffLocation,
  });

  Stream<List<ActiveNearbyDriverEntity>> initializeGeofireListener({
    required LocationEntity userLocation,
  });
}
