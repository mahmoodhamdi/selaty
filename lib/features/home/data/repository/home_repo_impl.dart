import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/auth/data/models/update_profile_request_model.dart';
import 'package:selaty/features/auth/data/models/update_profile_response_model.dart';
import 'package:selaty/features/home/data/data_sources/home_local_data_source.dart';
import 'package:selaty/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:selaty/features/home/data/models/cart.dart';
import 'package:selaty/features/home/data/models/categories_response.dart';
import 'package:selaty/features/home/data/models/get_profile_response.dart';
import 'package:selaty/features/home/data/models/get_user_favourite_response.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/data/models/slider_response.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepoImpl extends HomeRepo {
  @override
  Future<Either<String, List<SliderResponseData>>> getSliderImages() async {
    final remoteResult = await sl<HomeRemoteDataSource>().getSliderImages();
    return remoteResult.fold(
      (error) => Left(error),
      (sliderImages) async {
        return Right(sliderImages);
      },
    );
  }

  @override
  Future<Either<String, List<Category>>> getCategories() async {
    final localResult = await sl<HomeLocalDataSource>().getCategories();

    return localResult.fold(
      (error) async {
        final remoteResult = await sl<HomeRemoteDataSource>().getCategories();
        return remoteResult.fold(
          (error) => Left(error),
          (categories) async {
            sl<HomeLocalDataSource>().cacheCategories(categories);
            return Right(categories);
          },
        );
      },
      (categories) async {
        if (categories.isEmpty) {
          final remoteResult = await sl<HomeRemoteDataSource>().getCategories();
          return remoteResult.fold(
            (error) => Left(error),
            (categories) async {
              sl<HomeLocalDataSource>().cacheCategories(categories);
              return Right(categories);
            },
          );
        } else {
          return Right(categories);
        }
      },
    );
  }

  @override
  Future<Either<String, List<Product>>> getProducts({required int page}) async {
    return await sl<HomeRemoteDataSource>().getProducts(page: page);
  }

  @override
  Future<Either<String, List<FavouriteData>>> getUserFavourites() async {
    final result = await sl<HomeRemoteDataSource>().getUserFavourites();

    return result.fold(
      (error) => Left(error),
      (favourites) => Right(favourites),
    );
  }

  @override
  Future<Either<String, String>> addToFavourites(
      {required int productId}) async {
    final remoteResult =
        await sl<HomeRemoteDataSource>().addToFavourites(productId: productId);

    return remoteResult.fold(
      (error) => Left(error),
      (successMessage) async {
        // If adding to favorites remotely succeeds, update the local data source
        final updatedFavouritesResult =
            await sl<HomeRemoteDataSource>().getUserFavourites();

        updatedFavouritesResult.fold(
          (error) =>
              null, // Handle the error silently, or you could log it if needed
          (updatedFavourites) async {
            await sl<HomeLocalDataSource>()
                .cacheUserFavourites(updatedFavourites);
          },
        );

        return Right(successMessage);
      },
    );
  }

  @override
  Future<Either<String, UpdateProfileResponseData>> updateProfile({
    required UpdateProfileRequest request,
    required File profilePhoto,
  }) async {
    final result = await sl<HomeRemoteDataSource>()
        .updateProfile(request: request, profilePhoto: profilePhoto);
    return result.fold(
      (error) => Left(error),
      (success) async {
        return Right(success);
      },
    );
  }

  @override
  Future<Either<String, ProfileData>> getProfile() async {
    final result = await sl<HomeRemoteDataSource>().getProfile();
    return result.fold(
      (error) => Left(error),
      (success) async {
        return Right(success);
      },
    );
  }

  @override
  Future<void> addToCart(CartItem item) async {
    final token = sl<SharedPreferences>().getString('USER_TOKEN');
    sl<HomeLocalDataSource>().addToCart(token!, item);
  }

  @override
  Future<void> removeFromCart(String itemId) async {
    final token = sl<SharedPreferences>().getString('USER_TOKEN');
    sl<HomeLocalDataSource>().removeFromCart(token!, itemId);
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    final token = sl<SharedPreferences>().getString('USER_TOKEN');
    return await sl<HomeLocalDataSource>().getCartItems(token!);
  }

  @override
  Future<void> clearCart() async {
    final token = sl<SharedPreferences>().getString('USER_TOKEN');
    sl<HomeLocalDataSource>().clearCart(token!);
  }

  @override
  Future<void> updateQuantity(String itemId, int quantity) async {
    final token = sl<SharedPreferences>().getString('USER_TOKEN');
    sl<HomeLocalDataSource>().updateQuantity(token!, itemId, quantity);
  }
}
