import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:selaty/features/auth/data/models/update_profile_request_model.dart';
import 'package:selaty/features/auth/data/models/update_profile_response_model.dart';
import 'package:selaty/features/home/data/models/categories_response.dart';
import 'package:selaty/features/home/data/models/get_profile_response.dart';
import 'package:selaty/features/home/data/models/get_user_favourite_response.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/data/models/slider_response.dart';

abstract class HomeRepo {
  Future<Either<String, List<SliderResponseData>>> getSliderImages();

  Future<Either<String, List<Category>>> getCategories();
  Future<Either<String, List<Product>>> getProducts({required int page});
  Future<Either<String, List<FavouriteData>>> getUserFavourites();
  Future<Either<String, String>> addToFavourites({required int productId});
  Future<Either<String, UpdateProfileResponseData>> updateProfile({
    required UpdateProfileRequest request,
    required File profilePhoto,
  });
  Future<Either<String, ProfileData>> getProfile();
}
