import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:selaty/core/constants/api_constants.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/helpers/dio_exception_helper.dart';
import 'package:selaty/core/helpers/platform_exception_helper.dart';
import 'package:selaty/core/network/dio_client.dart';
import 'package:selaty/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:selaty/features/auth/data/models/update_profile_request_model.dart';
import 'package:selaty/features/auth/data/models/update_profile_response_model.dart';
import 'package:selaty/features/home/data/models/add_to_favourite_response.dart';
import 'package:selaty/features/home/data/models/categories_response.dart';
import 'package:selaty/features/home/data/models/get_profile_response.dart';
import 'package:selaty/features/home/data/models/get_user_favourite_response.dart'; // Import the model
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/data/models/slider_response.dart';

abstract class HomeRemoteDataSource {
  Future<Either<String, List<SliderResponseData>>> getSliderImages();
  Future<Either<String, List<Category>>> getCategories();
  Future<Either<String, List<Product>>> getProducts({required int page});
  Future<Either<String, String>> addToFavourites({required int productId});
  Future<Either<String, List<FavouriteData>>> getUserFavourites();
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
  Future<Either<String, List<FavouriteData>>> getUserFavourites() async {
    try {
      final token = await sl<AuthLocalDataSource>().getToken();
      var response = await sl<DioClient>().get(ApiConstants.userFavoritesUrl,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }));
      GetUserFavouriteResponse favouritesResponse =
          GetUserFavouriteResponse.fromJson(response.data);
      if (favouritesResponse.result) {
        return Right(favouritesResponse.data);
      } else {
        if (favouritesResponse.errorMessage == "لايوجد بيانات") {
          return Right(favouritesResponse.data);
        }
        return Left(favouritesResponse.errorMessage);
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
  Future<Either<String, String>> addToFavourites(
      {required int productId}) async {
    try {
      final token = await sl<AuthLocalDataSource>().getToken();
      var response = await sl<DioClient>().post(ApiConstants.addUserFavoriteUrl,
          data: {"favo_id": productId},
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }));
      AddToFavouriteResponse addFavouriteResponse =
          AddToFavouriteResponse.fromJson(response.data);
      if (addFavouriteResponse.result) {
        return Right(addFavouriteResponse.errorMessage);
      } else {
        return Left(addFavouriteResponse.errorMessage);
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
}
