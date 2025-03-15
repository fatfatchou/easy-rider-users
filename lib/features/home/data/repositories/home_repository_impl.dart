import 'package:users/features/home/data/models/location_model.dart';
import 'package:users/features/home/domain/repositories/home_repository.dart';
import 'package:geolocator/geolocator.dart' as gl;


class HomeRepositoryImpl implements HomeRepository{
  @override
  Stream<LocationModel> trackUserLocation() async* {
    bool isServiceEnabled = await gl.Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      throw Exception('Location services are disabled.');
    }

    gl.LocationPermission permission = await gl.Geolocator.checkPermission();
    if (permission == gl.LocationPermission.denied) {
      permission = await gl.Geolocator.requestPermission();
      if (permission == gl.LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == gl.LocationPermission.deniedForever) {
      throw Exception('Please enable location permissions in settings.');
    }

    gl.LocationSettings locationSettings = const gl.LocationSettings(
      accuracy: gl.LocationAccuracy.high,
      distanceFilter: 100,
    );

    yield* gl.Geolocator.getPositionStream(locationSettings: locationSettings)
        .map((gl.Position position) {
      return LocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    });
  }
}