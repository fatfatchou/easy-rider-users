import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/features/splash/domain/usecases/read_current_online_user_info_use_case.dart';
import 'package:users/features/splash/presentation/bloc/splash_event.dart';
import 'package:users/features/splash/presentation/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final ReadCurrentOnlineUserInfoUseCase readCurrentOnlineUserInfoUseCase;

  SplashBloc({required this.readCurrentOnlineUserInfoUseCase}) : super(SplashInitialState()) {
    on<ReadCurrentOnlineUserInfoEvent>(_onReadCurrentOnlineUserInfo);
  }

  Future<void> _onReadCurrentOnlineUserInfo(ReadCurrentOnlineUserInfoEvent event, Emitter<SplashState> emit) async {
    emit(SplashInitialState());
    try {
      final user = await readCurrentOnlineUserInfoUseCase.call();
      emit(SplashLoadedState(user: user));
    } catch (e) {
      emit(SplashFailuretate());
    }
  }
}