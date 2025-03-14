import 'package:users/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<void> call(
      {required String name,
      required String email,
      required String phone,
      required String password}) async {
    await authRepository.register(
        name: name, email: email, phone: phone, password: password);
  }
}
