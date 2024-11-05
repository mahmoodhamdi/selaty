import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:selaty/features/auth/data/models/update_profile_request_model.dart';
import 'package:selaty/features/auth/data/models/update_profile_response_model.dart';
import 'package:selaty/features/home/data/models/cart.dart';
import 'package:selaty/features/home/data/models/categories_response.dart';
import 'package:selaty/features/home/data/models/favourite_item.dart';
import 'package:selaty/features/home/data/models/get_profile_response.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/data/models/slider_response.dart';

abstract class HomeRepo {
  Future<Either<String, List<SliderResponseData>>> getSliderImages();

  Future<Either<String, List<Category>>> getCategories();
  Future<Either<String, List<Product>>> getProducts({required int page});
  Future<void> addToFavorites(FavoriteItem item);
  Future<void> removeFromFavorites(String itemId);
  Future<List<FavoriteItem>> getFavoriteItems();
  Future<void> clearFavorites();

  Future<Either<String, UpdateProfileResponseData>> updateProfile({
    required UpdateProfileRequest request,
    required File profilePhoto,
  });
  Future<Either<String, ProfileData>> getProfile();

  Future<void> addToCart(CartItem item);
  Future<void> removeFromCart(String itemId);
  Future<List<CartItem>> getCartItems();
  Future<void> clearCart();
  Future<void> updateQuantity(String itemId, int quantity);
}
