import 'package:users/features/home/domain/entities/active_nearby_driver_entity.dart';

class NearbyDriversWithStatus {
  final List<ActiveNearbyDriverEntity> drivers;
  final bool activeNearbyDriverKeysLoaded;

  NearbyDriversWithStatus({
    required this.drivers,
    required this.activeNearbyDriverKeysLoaded,
  });
}