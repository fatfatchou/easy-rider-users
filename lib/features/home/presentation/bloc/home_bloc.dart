import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:users/features/home/domain/usecases/get_polyline_use_case.dart';
import 'package:users/features/home/domain/usecases/get_user_location_use_case.dart';
import 'package:users/features/home/presentation/bloc/home_event.dart';
import 'package:users/features/home/presentation/bloc/home_state.dart';

import 'package:users/core/utils/map_utils.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserLocationUseCase getUserLocationUseCase;
  final GetPolylineUseCase getPolylineUseCase;

  HomeBloc(
      {required this.getUserLocationUseCase, required this.getPolylineUseCase})
      : super(HomeInitialState()) {
    on<GetUserLocationEvent>(_onGetUserLocation);
    on<UpdateDropoffLocationEvent>(_onUpdateDropoffLocation);
    on<GetPolylineEvent>(_onGetPolyline);
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
          dropoffLocation: event.dropoffLocation, // Update dropoff location
        ),
      );
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
