import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/features/auth/domain/usecases/login_use_case.dart';
import 'package:users/features/auth/domain/usecases/register_use_case.dart';
import 'package:users/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:users/features/auth/presentation/bloc/auth_state.dart';
import 'package:users/features/auth/presentation/bloc/auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  AuthBloc({required this.registerUseCase, required this.loginUseCase, required this.resetPasswordUseCase}) : super(AuthInitialState()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
    on<ResetPasswordEvent>(_onResetPassword);
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

  Future<void> _onResetPassword(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(ResetPasswordLoadingState());
    try {
      await resetPasswordUseCase.call(email: event.email);
      emit(ResetPasswordSuccessState(message: "Verification code sent to your email"));
    } catch (e) {
      emit(ResetPasswordFailureState(message: "Fail to send verification code. Please check again"));
    }
  }
}
