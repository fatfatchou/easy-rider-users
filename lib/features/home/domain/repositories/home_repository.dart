import 'package:users/features/home/domain/entities/direction_entity.dart';
import 'package:users/features/home/domain/entities/location_entity.dart';
import 'package:users/features/home/domain/entities/nearby_driver_with_status_entity.dart';

abstract class HomeRepository {
  Future<LocationEntity> getUserLocation();

  Future<DirectionEntity> getPolyline({
    required LocationEntity originLocation,
    required LocationEntity dropoffLocation,
  });

  Stream<NearbyDriversWithStatus> initializeGeofireListener({
    required LocationEntity userLocation,
    required bool activeNearbyDriverKeysLoaded,
  });
}
