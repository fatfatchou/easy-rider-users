import 'package:users/features/home/domain/entities/active_nearby_driver_entity.dart';

class ActiveNearbyDriverModel extends ActiveNearbyDriverEntity {
  ActiveNearbyDriverModel({
    required super.driverId,
    required super.latitude,
    required super.longitude,
  });

  factory ActiveNearbyDriverModel.fromJson(json) {
    return ActiveNearbyDriverModel(
      driverId: json['key'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
