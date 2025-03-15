import 'package:users/features/splash/domain/entities/user_entity.dart';
import 'package:users/features/splash/domain/repositories/splash_repository.dart';

class ReadCurrentOnlineUserInfoUseCase {
  final SplashRepository splashRepository;

  ReadCurrentOnlineUserInfoUseCase({required this.splashRepository});

  Future<UserEntity> call() async {
    return await splashRepository.readCurrentOnlineUserInfo();
  }
}