import 'package:users/features/home/domain/entities/location_entity.dart';
import 'package:users/features/home/domain/repositories/home_repository.dart';

class TrackUserLocationUseCase {
  final HomeRepository homeRepository;

  TrackUserLocationUseCase({required this.homeRepository});

  Stream<LocationEntity> call() {
    return homeRepository.trackUserLocation();
  }
}