import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/features/auth/domain/usecases/login_use_case.dart';
import 'package:users/features/auth/domain/usecases/register_use_case.dart';
import 'package:users/features/auth/presentation/bloc/auth_state.dart';
import 'package:users/features/auth/presentation/bloc/auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;

  AuthBloc({required this.registerUseCase, required this.loginUseCase}) : super(AuthInitialState()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await registerUseCase.call(
        name: event.name,
        email: event.email,
        phone: event.phone,
        password: event.password,
      );
      emit(AuthSuccessState(message: "Registered sucessfully"));
    } catch (e) {
      emit(AuthFailureState(message: "Registered fail"));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      await loginUseCase.call(email: event.email, password: event.password);
      emit(AuthSuccessState(message: "Login successfully"));
    } catch (e) {
      emit(AuthFailureState(message: "Login fail"));
    }
  }
}
