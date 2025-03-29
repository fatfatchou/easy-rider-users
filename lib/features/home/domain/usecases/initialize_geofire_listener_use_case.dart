import 'package:users/features/home/domain/entities/active_nearby_driver_entity.dart';
import 'package:users/features/home/domain/entities/location_entity.dart';
import 'package:users/features/home/domain/repositories/home_repository.dart';

class InitializeGeofireListenerUseCase {
  final HomeRepository homeRepository;

  InitializeGeofireListenerUseCase({required this.homeRepository});

  Stream<List<ActiveNearbyDriverEntity>> call({
    required LocationEntity userLocation,
  }) {
    return homeRepository.initializeGeofireListener(
        userLocation: userLocation);
  }
}
