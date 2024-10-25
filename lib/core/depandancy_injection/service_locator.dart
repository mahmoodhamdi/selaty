import 'package:get_it/get_it.dart';
import 'package:selaty/core/network/dio_client.dart';
import 'package:selaty/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:selaty/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:selaty/features/auth/data/repository/auth_repo_impl.dart';
import 'package:selaty/features/auth/domain/repository/auth_repo.dart';
import 'package:selaty/features/auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:selaty/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:selaty/features/auth/domain/usecases/login_usecase.dart';
import 'package:selaty/features/auth/domain/usecases/logout_usecase.dart';
import 'package:selaty/features/auth/domain/usecases/register_usecase.dart';
import 'package:selaty/features/auth/presentation/bloc/get_cached_user/get_cached_user_cubit.dart';
import 'package:selaty/features/auth/presentation/bloc/login/login_cubit.dart';
import 'package:selaty/features/auth/presentation/bloc/login_status/login_status_cubit.dart';
import 'package:selaty/features/auth/presentation/bloc/logout/logout_cubit.dart';
import 'package:selaty/features/auth/presentation/bloc/register/register_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Register SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Services
  sl.registerSingleton<DioClient>(DioClient());
// DataSources
  sl.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());
  sl.registerSingleton<AuthLocalDataSource>(
      AuthLocalDataSourceImpl(sharedPreferences: sharedPreferences));
// Repositories
  sl.registerSingleton<AuthRepo>(AuthRepoImpl());
// Auth Use Cases
  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase());
  sl.registerLazySingleton<RegisterUsecase>(() => RegisterUsecase());
  sl.registerLazySingleton<GetCachedUserUsecase>(() => GetCachedUserUsecase());
  sl.registerLazySingleton<IsLoggedInUsecase>(() => IsLoggedInUsecase());
  sl.registerLazySingleton<LogoutUsecase>(() => LogoutUsecase());
// cubits
  sl.registerFactory<RegisterCubit>(
    () => RegisterCubit(),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(),
  );
  sl.registerFactory<CachedUserCubit>(() => CachedUserCubit());
  sl.registerFactory<LoginStatusCubit>(() => LoginStatusCubit());
  sl.registerFactory<LogoutCubit>(() => LogoutCubit());
}
