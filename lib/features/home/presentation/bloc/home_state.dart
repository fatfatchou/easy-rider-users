import 'package:users/features/home/domain/entities/location_entity.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class GetUserLocationLoadingState extends HomeState {}

class GetUserLocationLoadedState extends HomeState {
  final LocationEntity location;

  GetUserLocationLoadedState({required this.location});
}

class GetUserLocationErrorState extends HomeState {
  final String message;

  GetUserLocationErrorState(this.message);
}
