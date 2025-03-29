import 'package:users/features/home/domain/entities/active_nearby_driver_entity.dart';


List<ActiveNearbyDriverEntity> deleteOfflineDriverFromList({required String driverId, required List<ActiveNearbyDriverEntity> activeNearbyDrivers}) {
  int index =
      activeNearbyDrivers.indexWhere((driver) => driver.driverId == driverId);

  activeNearbyDrivers.removeAt(index);
  return activeNearbyDrivers;
}

List<ActiveNearbyDriverEntity> updateActiveNearbyDriverLocation({required ActiveNearbyDriverEntity driver, required List<ActiveNearbyDriverEntity> activeNearbyDrivers}) {
  int index = activeNearbyDrivers.indexWhere(
    (element) => element.driverId == driver.driverId,
  );

  activeNearbyDrivers[index].latitude = driver.latitude;
  activeNearbyDrivers[index].longitude = driver.longitude;

  return activeNearbyDrivers;
}

List<ActiveNearbyDriverEntity> addActiveNearbyDriverToList({required ActiveNearbyDriverEntity driver, required List<ActiveNearbyDriverEntity> activeNearbyDrivers}) {
  activeNearbyDrivers.add(driver);

  return activeNearbyDrivers;
}
