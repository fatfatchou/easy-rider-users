import 'package:users/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<void> call({required String email, required String password}) async {
    await authRepository.login(email: email, password: password);
  }
}
