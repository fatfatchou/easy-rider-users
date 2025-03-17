import 'package:users/features/home/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel(
      {required super.locationName,
      required super.latitude,
      required super.longitude});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      locationName: json['properties']['full_address'],
      latitude: json['geometry']['coordinates'][1],
      longitude: json['geometry']['coordinates'][0],
    );
  }
}
