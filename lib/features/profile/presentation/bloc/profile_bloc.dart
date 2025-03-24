import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/features/profile/domain/usecases/get_current_user_use_case.dart';
import 'package:users/features/profile/presentation/bloc/profile_event.dart';
import 'package:users/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;

  ProfileBloc({required this.getCurrentUserUseCase})
      : super(ProfileInitialState()) {
    on<GetCurrentUserEvent>(_onGetCurrentUser);
  }

  Future<void> _onGetCurrentUser(
      GetCurrentUserEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    try {
      final user = await getCurrentUserUseCase.call();
      emit(ProfileLoadedState(user: user));
    } catch (e) {
      emit(ProfileFailureState(message: 'Failed to load user data'));
    }
  }
}
