import 'package:users/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository authRepository;

  ResetPasswordUseCase({required this.authRepository});

  Future<void> call({required email}) async {
    await authRepository.resetPassword(email: email);
  }
}