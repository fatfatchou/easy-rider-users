import 'package:users/features/home/domain/entities/location_entity.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final LocationEntity location;

  HomeLoadedState({required this.location});
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);
}