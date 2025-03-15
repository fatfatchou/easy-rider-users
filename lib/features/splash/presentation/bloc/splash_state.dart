import 'package:users/features/splash/domain/entities/user_entity.dart';

abstract class SplashState {}

class SplashInitialState extends SplashState {}

class SplashLoadingState extends SplashState {}

class SplashLoadedState extends SplashState {
  final UserEntity user;

  SplashLoadedState({required this.user});
}

class SplashFailuretate extends SplashState {}
