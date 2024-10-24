import 'package:get_it/get_it.dart';
import 'package:selaty/core/network/dio_client.dart';
import 'package:selaty/features/auth/data/data_sources/auth_remote_data_source/auth_remote_data_source.dart';
import 'package:selaty/features/auth/data/repository/auth_repo_impl.dart';
import 'package:selaty/features/auth/domain/repository/auth_repo.dart';
import 'package:selaty/features/auth/domain/usecases/login_usecase.dart';
import 'package:selaty/features/auth/domain/usecases/register_usecase.dart';
import 'package:selaty/features/auth/presentation/bloc/login/login_cubit.dart';
import 'package:selaty/features/auth/presentation/bloc/register/register_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Services
  sl.registerSingleton<DioClient>(DioClient());
// DataSources
  sl.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());
// Repositories
  sl.registerSingleton<AuthRepo>(AuthRepoImpl());
// Usecases
  sl.registerSingleton<RegisterUseCase>(RegisterUseCase());
  sl.registerSingleton<LoginUsecase>(LoginUsecase());

// cubits
  sl.registerFactory<RegisterCubit>(
    () => RegisterCubit(),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(),
  );
}
