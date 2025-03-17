import 'package:users/features/home/domain/entities/location_entity.dart';
import 'package:users/features/home/domain/repositories/home_repository.dart';

class GetUserLocationUseCase {
  final HomeRepository homeRepository;

  GetUserLocationUseCase({required this.homeRepository});

  Future<LocationEntity> call() {
    return homeRepository.getUserLocation();
  }
}
