import 'package:get_it/get_it.dart';
import 'package:users/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:users/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:users/features/auth/domain/repositories/auth_repository.dart';
import 'package:users/features/auth/domain/usecases/login_use_case.dart';
import 'package:users/features/auth/domain/usecases/register_use_case.dart';
import 'package:users/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:users/features/home/data/datasource/home_remote_data_source.dart';
import 'package:users/features/home/data/repositories/home_repository_impl.dart';
import 'package:users/features/home/domain/repositories/home_repository.dart';
import 'package:users/features/home/domain/usecases/get_polyline_use_case.dart';
import 'package:users/features/home/domain/usecases/get_user_location_use_case.dart';
import 'package:users/features/search/data/datasource/search_remote_data_source.dart';
import 'package:users/features/search/data/repositories/search_repository_impl.dart';
import 'package:users/features/search/domain/repositories/search_repository.dart';
import 'package:users/features/search/domain/usecase/get_automatically_suggestion_use_case.dart';
import 'package:users/features/search/domain/usecase/get_dropoff_location_use_case.dart';
import 'package:users/features/splash/data/datasources/splash_remote_data_source.dart';
import 'package:users/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:users/features/splash/domain/repositories/splash_repository.dart';
import 'package:users/features/splash/domain/usecases/read_current_online_user_info_use_case.dart';

final GetIt sl = GetIt.instance;

void setUpDependencies() {
  const String baseUrl = 'https://api.mapbox.com';

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(baseUrl: baseUrl));
  sl.registerLazySingleton<SplashRemoteDataSource>(
      () => SplashRemoteDataSource(baseUrl: baseUrl));
  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSource(baseUrl: baseUrl));
  sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSource(baseUrl: baseUrl));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: sl()));
  sl.registerLazySingleton<SplashRepository>(
      () => SplashRepositoryImpl(splashRemoteDataSource: sl()));
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(homeRemoteDataSource: sl()));
  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(searchRemoteDataSource: sl()));

  // Use cases
  sl.registerLazySingleton(() => RegisterUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => LoginUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(authRepository: sl()));
  sl.registerLazySingleton(
      () => ReadCurrentOnlineUserInfoUseCase(splashRepository: sl()));
  sl.registerLazySingleton(() => GetUserLocationUseCase(homeRepository: sl()));
  sl.registerLazySingleton(() => GetPolylineUseCase(homeRepository: sl()));
  sl.registerLazySingleton(() => GetAutomaticallySuggestionUseCase(searchRepository: sl()));
  sl.registerLazySingleton(() => GetDropoffLocationUseCase(searchRepository: sl()));
}
