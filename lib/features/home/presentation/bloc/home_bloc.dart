import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:users/features/home/data/datasource/home_remote_data_source.dart';
import 'package:users/features/home/data/datasource/home_remote_data_source.dart'; // Import for NearbyDriversWithStatus
import 'package:users/features/home/domain/entities/active_nearby_driver_entity.dart';
import 'package:users/features/home/domain/usecases/get_polyline_use_case.dart';
import 'package:users/features/home/domain/usecases/get_user_location_use_case.dart';
import 'package:users/features/home/domain/usecases/initialize_geofire_listener_use_case.dart';
import 'package:users/features/home/presentation/bloc/home_event.dart';
import 'package:users/features/home/presentation/bloc/home_state.dart';
import 'package:users/core/utils/map_utils.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserLocationUseCase getUserLocationUseCase;
  final GetPolylineUseCase getPolylineUseCase;
  final InitializeGeofireListenerUseCase initializeGeofireListenerUseCase;

  HomeBloc({
    required this.getUserLocationUseCase,
    required this.getPolylineUseCase,
    required this.initializeGeofireListenerUseCase,
  }) : super(HomeInitialState()) {
    on<GetUserLocationEvent>(_onGetUserLocation);
    on<UpdateDropoffLocationEvent>(_onUpdateDropoffLocation);
    on<GetPolylineEvent>(_onGetPolyline);
    on<InitializeGeofireListenerEvent>(_onInitializeGeofireListener);
  }

  Future<void> _onGetUserLocation(
      GetUserLocationEvent event, Emitter<HomeState> emit) async {
    emit(GetUserLocationLoadingState());
    try {
      final location = await getUserLocationUseCase.call();
      emit(HomeLoadedState(location: location));
    } catch (e) {
      emit(GetUserLocationErrorState('Fail to get user current location'));
    }
  }

  void _onUpdateDropoffLocation(
      UpdateDropoffLocationEvent event, Emitter<HomeState> emit) {
    final currentState = state;
    if (currentState is HomeLoadedState) {
      emit(
        HomeLoadedState(
          location: currentState.location,
          dropoffLocation: event.dropoffLocation,
          direction: currentState.direction,
          polylinePoints: currentState.polylinePoints,
          centerPoint: currentState.centerPoint,
          nearbyDrivers: currentState.nearbyDrivers,
          activeNearbyDriverKeysLoaded: currentState.activeNearbyDriverKeysLoaded,
        ),
      );
    }
  }

  Future<void> _onInitializeGeofireListener(
      InitializeGeofireListenerEvent event, Emitter<HomeState> emit) async {
    try {
      await emit.forEach<NearbyDriversWithStatus>(
        initializeGeofireListenerUseCase.call(
          userLocation: event.userLocation,
          activeNearbyDriverKeysLoaded: event.activeNearbyDriverKeysLoaded,
        ),
        onData: (NearbyDriversWithStatus data) {
          print("Updated Nearby Drivers in Bloc: ${data.drivers}");
          return HomeLoadedState(
            location: event.userLocation,
            nearbyDrivers: data.drivers,
            activeNearbyDriverKeysLoaded: data.activeNearbyDriverKeysLoaded,
          );
        },
        onError: (error, stackTrace) {
          print("Error in Geofire Stream: $error");
          return InitializeGeofireListenerErrorState(
              'Failed to fetch nearby drivers');
        },
      );
    } catch (e) {
      emit(InitializeGeofireListenerErrorState(
          'Failed to fetch nearby drivers'));
    }
  }

  Future<void> _onGetPolyline(
      GetPolylineEvent event, Emitter<HomeState> emit) async {
    emit(GetPolylineLoadingState());
    try {
      final direction = await getPolylineUseCase.call(
        originLocation: event.originLocation,
        dropoffLocation: event.dropoffLocation,
      );

      // Decode the polyline
      PolylinePoints polylinePoints = PolylinePoints();
      List<Point> decodedPolyline = polylinePoints
          .decodePolyline(direction.ePoints)
          .map((point) => Point(
                coordinates: Position(point.longitude, point.latitude),
              ))
          .toList();

      Position centerPoint =
          getCenterCoordinatesForPolyline(points: decodedPolyline);

      emit(HomeLoadedState(
        location: event.originLocation,
        dropoffLocation: event.dropoffLocation,
        direction: direction,
        polylinePoints: decodedPolyline,
        centerPoint: centerPoint,
      ));
    } catch (e) {
      emit(GetPolylineErrorState('Fail to get route'));
    }
  }
}