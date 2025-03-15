import 'package:users/features/home/domain/entities/location_entity.dart';

abstract class HomeRepository {
  Stream<LocationEntity> trackUserLocation();
}