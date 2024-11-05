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
import 'package:selaty/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:selaty/features/auth/domain/usecases/set_new_password_usecase.dart';
import 'package:selaty/features/auth/presentation/logic/forget_password/send_otp_cubit.dart';
import 'package:selaty/features/auth/presentation/logic/get_cached_user/get_cached_user_cubit.dart';
import 'package:selaty/features/auth/presentation/logic/login/login_cubit.dart';
import 'package:selaty/features/auth/presentation/logic/login_status/login_status_cubit.dart';
import 'package:selaty/features/auth/presentation/logic/logout/logout_cubit.dart';
import 'package:selaty/features/auth/presentation/logic/register/register_cubit.dart';
import 'package:selaty/features/auth/presentation/logic/set_new_password/set_new_password_cubit.dart';
import 'package:selaty/features/home/data/data_sources/home_local_data_source.dart';
import 'package:selaty/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:selaty/features/home/data/repository/home_repo_impl.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';
import 'package:selaty/features/home/domain/usecases/add_to_cart_usecase.dart';
import 'package:selaty/features/home/domain/usecases/add_to_favourites_usecase.dart';
import 'package:selaty/features/home/domain/usecases/clear_cart_usecase.dart';
import 'package:selaty/features/home/domain/usecases/get_cart_usecase.dart';
import 'package:selaty/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:selaty/features/home/domain/usecases/get_products_usecase.dart';
import 'package:selaty/features/home/domain/usecases/get_profile_usecase.dart';
import 'package:selaty/features/home/domain/usecases/get_slider_images_usecase.dart';
import 'package:selaty/features/home/domain/usecases/get_user_favourites_usecase.dart';
import 'package:selaty/features/home/domain/usecases/remove_from_cart_usecase.dart';
import 'package:selaty/features/home/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:selaty/features/home/domain/usecases/update_profile_usecase.dart';
import 'package:selaty/features/home/presentation/logic/cart/cart_cubit.dart';
import 'package:selaty/features/home/presentation/logic/categories/categories_cubit.dart';
import 'package:selaty/features/home/presentation/logic/get_user_favourites/favourites_cubit.dart';
import 'package:selaty/features/home/presentation/logic/product/product_cubit.dart';
import 'package:selaty/features/home/presentation/logic/profile/get_profile_cubit.dart';
import 'package:selaty/features/home/presentation/logic/slider_images/slider_images_cubit.dart';
import 'package:selaty/features/home/presentation/logic/update_profile/update_profile_cubit.dart';
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
  sl.registerSingleton<HomeRemoteDataSource>(HomeRemoteDataSourceImpl());
  sl.registerSingleton<AuthLocalDataSource>(
      AuthLocalDataSourceImpl(sharedPreferences: sharedPreferences));
  sl.registerSingleton<HomeLocalDataSource>(HomeLocalDataSourceImpl());
// Repositories
  sl.registerSingleton<AuthRepo>(AuthRepoImpl());
  sl.registerSingleton<HomeRepo>(HomeRepoImpl());

// Auth Use Cases
  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase());
  sl.registerLazySingleton<RegisterUsecase>(() => RegisterUsecase());
  sl.registerLazySingleton<GetCachedUserUsecase>(() => GetCachedUserUsecase());
  sl.registerLazySingleton<IsLoggedInUsecase>(() => IsLoggedInUsecase());
  sl.registerLazySingleton<LogoutUsecase>(() => LogoutUsecase());
  sl.registerLazySingleton<SendOtpUsecase>(() => SendOtpUsecase());
  sl.registerLazySingleton<SetNewPasswordUsecase>(
      () => SetNewPasswordUsecase());
  sl.registerLazySingleton<UpdateProfileUsecase>(() => UpdateProfileUsecase());

// auth cubits
  sl.registerFactory<RegisterCubit>(
    () => RegisterCubit(),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(),
  );
  //home use cases
  sl.registerLazySingleton<GetSliderImagesUseCase>(
      () => GetSliderImagesUseCase());
  sl.registerLazySingleton<GetCategoriesUsecase>(() => GetCategoriesUsecase());
  sl.registerLazySingleton<GetProductsUsecase>(() => GetProductsUsecase());
  sl.registerLazySingleton<GetUserFavouritesUsecase>(
      () => GetUserFavouritesUsecase());
  sl.registerLazySingleton<AddToFavouritesUsecase>(
      () => AddToFavouritesUsecase());
  sl.registerLazySingleton<GetProfileUsecase>(() => GetProfileUsecase());
  sl.registerLazySingleton<AddToCartUseCase>(() => AddToCartUseCase());
  sl.registerLazySingleton<RemoveFromCartUseCase>(
      () => RemoveFromCartUseCase());
  sl.registerLazySingleton<ClearCartUseCase>(() => ClearCartUseCase());
  sl.registerLazySingleton<GetCartItemsUseCase>(() => GetCartItemsUseCase());
  sl.registerLazySingleton<UpdateQuantityUseCase>(
      () => UpdateQuantityUseCase());

// home cubits
  sl.registerFactory<CachedUserCubit>(() => CachedUserCubit());
  sl.registerFactory<LoginStatusCubit>(() => LoginStatusCubit());
  sl.registerFactory<LogoutCubit>(() => LogoutCubit());
  sl.registerFactory<SendOtpCubit>(() => SendOtpCubit());
  sl.registerFactory<SetNewPasswordCubit>(() => SetNewPasswordCubit());
  sl.registerFactory<UpdateProfileCubit>(() => UpdateProfileCubit());
  sl.registerFactory<GetProfileCubit>(() => GetProfileCubit());
  sl.registerFactory<CartCubit>(() => CartCubit(
        addToCart: sl<AddToCartUseCase>(),
        removeFromCart: sl<RemoveFromCartUseCase>(),
        clearCart: sl<ClearCartUseCase>(),
        getCartItems: sl<GetCartItemsUseCase>(),
        updateQuantity: sl<UpdateQuantityUseCase>(),
      ));

  sl.registerFactory<SliderImagesCubit>(() => SliderImagesCubit());
  sl.registerFactory<CategoriesCubit>(() => CategoriesCubit());
  sl.registerFactory<ProductCubit>(() => ProductCubit());
  sl.registerFactory<FavouritesCubit>(() => FavouritesCubit(
        [],
      ));
}
