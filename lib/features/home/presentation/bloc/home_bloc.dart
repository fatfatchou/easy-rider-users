import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/features/home/domain/entities/location_entity.dart';
import 'package:users/features/home/domain/usecases/track_user_location_use_case.dart';
import 'package:users/features/home/presentation/bloc/home_event.dart';
import 'package:users/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TrackUserLocationUseCase trackUserLocationUseCase;
  StreamSubscription<LocationEntity>? locationSubscription;

  HomeBloc({required this.trackUserLocationUseCase}) : super(HomeInitialState()) {
    on<TrackUserLocationEvent>(_onTrackUserLocation);
  }

  void _onTrackUserLocation(TrackUserLocationEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    
    try {
      locationSubscription?.cancel();
      locationSubscription = trackUserLocationUseCase.call().listen(
        (location) {
          emit(HomeLoadedState(location: location));
        },
        onError: (error) {
          emit(HomeErrorState(error.toString()));
        },
      );
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }
}