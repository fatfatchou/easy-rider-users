import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:users/features/home/domain/entities/direction_entity.dart';
import 'package:users/features/home/domain/entities/location_entity.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class GetUserLocationLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final LocationEntity location;
  final LocationEntity? dropoffLocation; // Nullable initially
  final DirectionEntity? direction;
  final List<Point>? polylinePoints;
  final Position? centerPoint;

  HomeLoadedState({
    required this.location,
    this.dropoffLocation,
    this.direction,
    this.polylinePoints,
    this.centerPoint,
  });
}

class GetUserLocationErrorState extends HomeState {
  final String message;

  GetUserLocationErrorState(this.message);
}

class GetPolylineLoadingState extends HomeState {}

class GetPolylineErrorState extends HomeState {
  final String message;

  GetPolylineErrorState(this.message);
}
