import 'package:users/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:users/features/profile/domain/repositories/profile_repository.dart';
import 'package:users/features/profile/data/models/user_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl({required this.profileRemoteDataSource});

  @override
  Future<UserModel> getCurrentUser() async {
    return await profileRemoteDataSource.getCurrentUser();
  }
}
