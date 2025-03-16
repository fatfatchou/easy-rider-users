import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/features/home/domain/entities/location_entity.dart';
import 'package:users/features/home/domain/usecases/track_user_location_use_case.dart';
import 'package:users/features/home/presentation/bloc/home_event.dart';
import 'package:users/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TrackUserLocationUseCase trackUserLocationUseCase;
  StreamSubscription<LocationEntity>? userPositionStream;

  HomeBloc({required this.trackUserLocationUseCase}) : super(HomeInitialState()) {
    on<TrackUserLocationEvent>(_onTrackUserLocation);
  }

  void _onTrackUserLocation(TrackUserLocationEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    
    try {
      userPositionStream?.cancel();
      await for (final location in trackUserLocationUseCase.call()) {
        if (emit.isDone) return; // ✅ Ensure the Bloc is still active before emitting
        emit(HomeLoadedState(location: location));
      }
      // userPositionStream = trackUserLocationUseCase.call().listen(
      //   (location) {
      //     emit(HomeLoadedState(location: location));
      //   },
      //   onError: (error) {
      //     emit(HomeErrorState(error.toString()));
      //   },
      // );
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    userPositionStream?.cancel();
    return super.close();
  }
}