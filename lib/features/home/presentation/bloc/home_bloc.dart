import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/features/home/domain/entities/location_entity.dart';
import 'package:users/features/home/domain/usecases/get_user_location_use_case.dart';
import 'package:users/features/home/domain/usecases/track_user_location_use_case.dart';
import 'package:users/features/home/presentation/bloc/home_event.dart';
import 'package:users/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserLocationUseCase getUserLocationUseCase;
  final TrackUserLocationUseCase trackUserLocationUseCase;
  StreamSubscription<LocationEntity>? userPositionStream;

  HomeBloc(
      {required this.trackUserLocationUseCase,
      required this.getUserLocationUseCase})
      : super(HomeInitialState()) {
    on<GetUserLocationEvent>(_onGetUserLocation);
    // on<TrackUserLocationEvent>(_onTrackUserLocation);
  }

  Future<void> _onGetUserLocation(
      GetUserLocationEvent event, Emitter<HomeState> emit) async {
    emit(GetUserLocationLoadingState());
    try {
      final location = await getUserLocationUseCase.call();
      emit(GetUserLocationLoadedState(location: location));
    } catch (e) {
      emit(GetUserLocationErrorState('Fail to get user current location'));
    }
  }

  // void _onTrackUserLocation(
  //     TrackUserLocationEvent event, Emitter<HomeState> emit) async {
  //   emit(HomeLoadingState());

  //   try {
  //     userPositionStream?.cancel();
  //     await for (final location in trackUserLocationUseCase.call()) {
  //       if (emit.isDone)
  //         return; // ✅ Ensure the Bloc is still active before emitting
  //       emit(HomeLoadedState(location: location));
  //     }
  //     // userPositionStream = trackUserLocationUseCase.call().listen(
  //     //   (location) {
  //     //     emit(HomeLoadedState(location: location));
  //     //   },
  //     //   onError: (error) {
  //     //     emit(HomeErrorState(error.toString()));
  //     //   },
  //     // );
  //   } catch (e) {
  //     emit(HomeErrorState(e.toString()));
  //   }
  // }

  // @override
  // Future<void> close() {
  //   userPositionStream?.cancel();
  //   return super.close();
  // }
}
