import 'package:users/features/profile/domain/entities/user_entity.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final UserEntity user;

  ProfileLoadedState({required this.user});
}

class ProfileFailureState extends ProfileState {
  final String message;

  ProfileFailureState({required this.message});
}
