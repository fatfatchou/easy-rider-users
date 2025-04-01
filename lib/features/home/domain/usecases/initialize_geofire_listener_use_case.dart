import 'package:users/features/home/domain/entities/location_entity.dart';
import 'package:users/features/home/domain/entities/nearby_driver_with_status_entity.dart';
import 'package:users/features/home/domain/repositories/home_repository.dart';

class InitializeGeofireListenerUseCase {
  final HomeRepository homeRepository;

  InitializeGeofireListenerUseCase({required this.homeRepository});

  Stream<NearbyDriversWithStatus> call({
    required LocationEntity userLocation,
    required bool activeNearbyDriverKeysLoaded,
  }) {
    return homeRepository.initializeGeofireListener(
      userLocation: userLocation,
      activeNearbyDriverKeysLoaded: activeNearbyDriverKeysLoaded,
    );
  }
}
