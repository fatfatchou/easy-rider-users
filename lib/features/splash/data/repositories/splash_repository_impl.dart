import 'package:users/features/splash/data/datasources/splash_remote_data_source.dart';
import 'package:users/features/splash/data/models/user_model.dart';
import 'package:users/features/splash/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashRemoteDataSource splashRemoteDataSource;

  SplashRepositoryImpl({required this.splashRemoteDataSource});

  @override
  Future<UserModel> readCurrentOnlineUserInfo() async {
    return await splashRemoteDataSource.readCurrentOnlineUserInfo();
  }
}