import 'package:users/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:users/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    await authRemoteDataSource.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
  }

  @override
  Future<void> login({required String email, required String password}) async {
    await authRemoteDataSource.login(email: email, password: password);
  }
  
  @override
  Future<void> resetPassword({required String email}) async {
    await authRemoteDataSource.resetPassword(email: email);
  }
}
