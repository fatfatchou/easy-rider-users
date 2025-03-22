import 'package:users/features/home/domain/entities/direction_entity.dart';
import 'package:users/features/home/domain/entities/location_entity.dart';
import 'package:users/features/home/domain/repositories/home_repository.dart';

class GetPolylineUseCase {
  final HomeRepository homeRepository;

  GetPolylineUseCase({required this.homeRepository});

  Future<DirectionEntity> call({required LocationEntity originLocation, required LocationEntity dropoffLocation}) {
    return homeRepository.getPolyline(originLocation: originLocation, dropoffLocation: dropoffLocation);
  }
}