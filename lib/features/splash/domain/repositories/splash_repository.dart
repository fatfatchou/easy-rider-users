import 'package:users/features/splash/domain/entities/user_entity.dart';

abstract class SplashRepository {
  Future<UserEntity> readCurrentOnlineUserInfo();
}