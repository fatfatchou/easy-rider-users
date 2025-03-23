import 'package:users/features/profile/domain/repositories/profile_repository.dart';
import 'package:users/features/profile/domain/entities/user_entity.dart';

class GetCurrentUserUseCase {
  final ProfileRepository profileRepository;

  GetCurrentUserUseCase({required this.profileRepository});

  Future<UserEntity> call() async {
    return await profileRepository.getCurrentUser();
  }
}
