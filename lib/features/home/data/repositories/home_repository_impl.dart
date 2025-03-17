import 'package:users/features/home/data/datasource/home_remote_data_source.dart';
import 'package:users/features/home/data/models/location_model.dart';
import 'package:users/features/home/domain/entities/location_entity.dart';
import 'package:users/features/home/domain/repositories/home_repository.dart';
import 'package:geolocator/geolocator.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl({required this.homeRemoteDataSource});

  @override
  Future<LocationEntity> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 50
      )
    );

    double latitude = position.latitude;
    double longitude = position.longitude;

    print('longitude: $longitude, latitude: $latitude');

    // Call remote data source to perform reverse geocoding
    try {
      String locationName = await homeRemoteDataSource.getAddressFromCoordinates(position: position);
      
      return LocationModel(
        locationName: locationName,
        latitude: latitude,
        longitude: longitude,
      );
    } catch (e) {
      print(e);
      return Future.error('Failed to fetch address: $e');
    }
  }

  

  @override
  Stream<LocationEntity> trackUserLocation() async* {
    // bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!isServiceEnabled) {
    //   throw Exception('Location services are disabled.');
    // }

    // LocationPermission permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     throw Exception('Location permissions are denied.');
    //   }
    // }

    // if (permission == LocationPermission.deniedForever) {
    //   throw Exception('Please enable location permissions in settings.');
    // }

    // LocationSettings locationSettings = const LocationSettings(
    //   accuracy: LocationAccuracy.high,
    //   distanceFilter: 100,
    // );

    // yield* Geolocator.getPositionStream(locationSettings: locationSettings)
    //     .map((Position position) {
    //   return LocationModel(
    //     latitude: position.latitude,
    //     longitude: position.longitude,
    //   );
    // });
  }
}
