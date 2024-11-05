import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:selaty/core/constants/api_constants.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/helpers/dio_exception_helper.dart';
import 'package:selaty/core/helpers/logger_helper.dart';
import 'package:selaty/core/helpers/platform_exception_helper.dart';
import 'package:selaty/core/network/dio_client.dart';
import 'package:selaty/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:selaty/features/auth/data/models/update_profile_request_model.dart';
import 'package:selaty/features/auth/data/models/update_profile_response_model.dart';
import 'package:selaty/features/home/data/models/categories_response.dart';
import 'package:selaty/features/home/data/models/favourite_item.dart';
import 'package:selaty/features/home/data/models/get_profile_response.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/data/models/slider_response.dart';

abstract class HomeRemoteDataSource {
  Future<Either<String, List<SliderResponseData>>> getSliderImages();
  Future<Either<String, List<Category>>> getCategories();
  Future<Either<String, List<Product>>> getProducts({required int page});
  Future<void> addToFavorites(FavoriteItem item);
  Future<void> removeFromFavorites(String itemId);
  Future<List<FavoriteItem>> getFavoriteItems();

  Future<Either<String, UpdateProfileResponseData>> updateProfile({
    required UpdateProfileRequest request,
    required File profilePhoto,
  });
  Future<Either<String, ProfileData>> getProfile();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<Either<String, ProfileData>> getProfile() async {
    try {
      final token = await sl<AuthLocalDataSource>().getToken();
      var response = await sl<DioClient>().get(
        ApiConstants.userProfileUrl,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      GetProfileResponse getProfileResponse =
          GetProfileResponse.fromJson(response.data);
      if (getProfileResponse.status) {
        return Right(getProfileResponse.data!);
      } else {
        return Left(getProfileResponse.message ?? 'Unknown error');
      }
    } on DioException catch (e) {
      return Left(DioExceptionHelper.handleDioError(e));
    } on PlatformException catch (e) {
      return Left(PlatformExceptionHelper.handlePlatformError(e));
    } catch (e) {
      return Left('حدث خطأ غير متوقع: $e');
    }
  }

  @override
  Future<Either<String, List<SliderResponseData>>> getSliderImages() async {
    try {
      var response = await sl<DioClient>().get(ApiConstants.sliderUrl);
      SliderResponse sliderResponse = SliderResponse.fromJson(response.data);
      if (sliderResponse.result) {
        return Right(sliderResponse.data!);
      } else {
        return Left(sliderResponse.errorMessage);
      }
    } on DioException catch (e) {
      return Left(DioExceptionHelper.handleDioError(e));
    } on PlatformException catch (e) {
      return Left(PlatformExceptionHelper.handlePlatformError(e));
    } catch (e) {
      return Left('حدث خطأ غير متوقع: $e');
    }
  }

  @override
  Future<Either<String, List<Category>>> getCategories() async {
    try {
      var response =
          await sl<DioClient>().get(ApiConstants.categoriesWithSubUrl);
      CategoriesResponse categoriesResponse =
          CategoriesResponse.fromJson(response.data);
      if (categoriesResponse.result) {
        return Right(categoriesResponse.data);
      } else {
        return Left(categoriesResponse.errorMessage);
      }
    } on DioException catch (e) {
      return Left(DioExceptionHelper.handleDioError(e));
    } on PlatformException catch (e) {
      return Left(PlatformExceptionHelper.handlePlatformError(e));
    } catch (e) {
      return Left('حدث خطاء غير متوقع: $e');
    }
  }

  @override
  Future<Either<String, List<Product>>> getProducts({required int page}) async {
    try {
      var response = await sl<DioClient>()
          .get(ApiConstants.getProductsByPageUrl(page.toString()));
      ProductResponse productsResponse =
          ProductResponse.fromJson(response.data);
      if (productsResponse.status) {
        return Right(productsResponse.data.products);
      } else {
        return Left(productsResponse.message);
      }
    } on DioException catch (e) {
      return Left(DioExceptionHelper.handleDioError(e));
    } on PlatformException catch (e) {
      return Left(PlatformExceptionHelper.handlePlatformError(e));
    } catch (e) {
      return Left('حدث خطاء غير متوقع: $e');
    }
  }

  @override
  Future<Either<String, UpdateProfileResponseData>> updateProfile({
    required UpdateProfileRequest request,
    required File profilePhoto,
  }) async {
    try {
      final token = await sl<AuthLocalDataSource>().getToken();
      var response = await sl<DioClient>().post(
        ApiConstants.updateProfileUrl,
        data: FormData.fromMap({
          'name': request.name,
          'mobile': request.mobile,
          'email': request.email,
          'profile_photo_path': await MultipartFile.fromFile(profilePhoto.path),
        }),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      UpdateProfileResponse updateProfileResponse =
          UpdateProfileResponse.fromJson(response.data);

      if (updateProfileResponse.status) {
        return Right(updateProfileResponse.data!);
      } else {
        return Left(updateProfileResponse.errorMessage ?? 'Unknown error');
      }
    } on DioException catch (e) {
      return Left(DioExceptionHelper.handleDioError(e));
    } on PlatformException catch (e) {
      return Left(PlatformExceptionHelper.handlePlatformError(e));
    } catch (e) {
      return Left('حدث خطأ غير متوقع: $e');
    }
  }

  @override
  Future<void> addToFavorites(FavoriteItem item) async {
    try {
      final token = await sl<AuthLocalDataSource>().getToken();
      await sl<DioClient>().post(
        ApiConstants.addUserFavoriteUrl,
        data: {"favo_id": item.id},
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      LoggerHelper.debug("Item added to favorites: ${item.name}");
    } on DioException catch (e) {
      LoggerHelper.error("Error adding item to favorites: ${item.name}", e);
    } on PlatformException catch (e) {
      LoggerHelper.error("Error adding item to favorites: ${item.name}", e);
    } catch (e) {
      LoggerHelper.error("Error adding item to favorites: ${item.name}", e);
    }
  }

  @override
  Future<List<FavoriteItem>> getFavoriteItems() async {
    final token = await sl<AuthLocalDataSource>().getToken();
    try {
      var response = await sl<DioClient>().get(
        ApiConstants.userFavoritesUrl,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );
      List<FavoriteItem> favorites = FavoriteItem.decodeList(response.data);
      LoggerHelper.debug("Favorites loaded: ${favorites.length} items");
      return favorites;
    } on DioException catch (e) {
      LoggerHelper.error("Error loading favorites", e);
      return [];
    } on PlatformException catch (e) {
      LoggerHelper.error("Error loading favorites", e);
      return [];
    } catch (e) {
      LoggerHelper.error("Error loading favorites", e);
      return [];
    }
  }

  @override
  Future<void> removeFromFavorites(String itemId) async {
    try {
      final token = await sl<AuthLocalDataSource>().getToken();
      await sl<DioClient>().post(
        ApiConstants.addUserFavoriteUrl,
        data: {"favo_id": itemId},
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      LoggerHelper.debug("Item removed from favorites: ID $itemId");
    } on DioException catch (e) {
      LoggerHelper.error("Error removing item from favorites: ID $itemId", e);
    } on PlatformException catch (e) {
      LoggerHelper.error("Error removing item from favorites: ID $itemId", e);
    } catch (e) {
      LoggerHelper.error("Error removing item from favorites: ID $itemId", e);
    }
  }
}
