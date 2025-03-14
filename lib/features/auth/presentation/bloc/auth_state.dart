abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final String message;

  AuthSuccessState({required this.message});
}

class AuthFailureState extends AuthState {
  final String message;

  AuthFailureState({required this.message});
}
