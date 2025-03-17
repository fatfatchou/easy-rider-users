import 'package:users/features/home/domain/entities/location_entity.dart';

abstract class HomeRepository {
  Future<LocationEntity> getUserLocation();
  Stream<LocationEntity> trackUserLocation();
}