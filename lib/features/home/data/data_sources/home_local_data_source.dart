import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/helpers/logger_helper.dart';
import 'package:selaty/features/home/data/models/cart.dart';
import 'package:selaty/features/home/data/models/categories_response.dart';
import 'package:selaty/features/home/data/models/favourite_item.dart';
import 'package:selaty/features/home/data/models/get_profile_response.dart';
import 'package:selaty/features/home/data/models/get_user_favourite_response.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeLocalDataSource {
  Future<Either<String, List<Category>>> getCategories();
  Future<Either<String, void>> cacheCategories(List<Category> categories);
  Future<Either<String, List<Product>>> getProducts();
  Future<Either<String, void>> cacheProducts(List<Product> products);
  Future<Either<String, void>> cacheUserFavourites(
      List<FavouriteData> favourites);
  Future<Either<String, ProfileData>> getProfile();
  Future<Either<String, void>> cacheProfile(ProfileData profile);

  Future<void> addToCart(String token, CartItem item);
  Future<void> removeFromCart(String token, String itemId);
  Future<List<CartItem>> getCartItems(String token);
  Future<void> clearCart(String token);
  Future<void> updateQuantity(String token, String itemId, int quantity);
  Future<void> addToFavorites(String token, FavoriteItem item);
  Future<void> removeFromFavorites(String token, String itemId);
  Future<List<FavoriteItem>> getFavoriteItems(String token);
  Future<void> clearFavorites(String token);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<void> addToFavorites(String token, FavoriteItem item) async {
    final favorites = await _getFavorites(token);
    favorites.add(item);
    await _saveFavorites(token, favorites);
  }

  @override
  Future<void> removeFromFavorites(String token, String itemId) async {
    final favorites = await _getFavorites(token);
    favorites.removeWhere((item) => item.id.toString() == itemId);
    await _saveFavorites(token, favorites);
  }

  @override
  Future<List<FavoriteItem>> getFavoriteItems(String token) async {
    return await _getFavorites(token);
  }

  @override
  Future<void> clearFavorites(String token) async {
    await sl<SharedPreferences>().remove(_getFavoritesKey(token));
  }

  Future<List<FavoriteItem>> _getFavorites(String token) async {
    final favoritesString =
        sl<SharedPreferences>().getString(_getFavoritesKey(token));
    if (favoritesString != null) {
      return FavoriteItem.decodeList(favoritesString);
    }
    return [];
  }

  Future<void> _saveFavorites(
      String token, List<FavoriteItem> favorites) async {
    final favoritesString = FavoriteItem.encodeList(favorites);
    await sl<SharedPreferences>()
        .setString(_getFavoritesKey(token), favoritesString);
  }

  String _getFavoritesKey(String token) => 'favorites_$token';

  @override
  Future<Either<String, void>> cacheCategories(
      List<Category> categories) async {
    try {
      final jsonString =
          json.encode(categories.map((category) => category.toJson()).toList());
      sl<SharedPreferences>().setString('categories', jsonString);
      LoggerHelper.info("Cached categories in Shared Preferences");
      return const Right(null);
    } catch (e) {
      LoggerHelper.error("Failed to cache Categories: $e");
      return const Left("Failed to cache Categories");
    }
  }

  @override
  Future<Either<String, List<Category>>> getCategories() async {
    try {
      final jsonString = sl<SharedPreferences>().getString('categories');
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        final List<Category> categories =
            jsonList.map((json) => Category.fromJson(json)).toList();
        LoggerHelper.info("Loaded cached categories from Shared Preferences");
        return Right(categories);
      } else {
        LoggerHelper.warning("No cached categories found");
        return const Left("No cached categories found");
      }
    } catch (e) {
      LoggerHelper.error("Failed to decode cached categories: $e");
      return const Left("Failed to decode cached categories");
    }
  }

  Future<Either<String, void>> clearCache() async {
    try {
      sl<SharedPreferences>().remove('slider_images');
      sl<SharedPreferences>().remove('categories');
      return const Right(null);
    } catch (e) {
      LoggerHelper.error("Failed to clear cache: $e");
      return const Left("Failed to clear cache");
    }
  }

  @override
  Future<Either<String, List<Product>>> getProducts() async {
    try {
      final jsonString = sl<SharedPreferences>().getString('products');
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        final List<Product> products =
            jsonList.map((json) => Product.fromJson(json)).toList();
        LoggerHelper.info("Loaded cached products from Shared Preferences");
        return Right(products);
      } else {
        LoggerHelper.warning("No cached products found");
        return const Left("No cached products found");
      }
    } catch (e) {
      LoggerHelper.error("Failed to decode cached products: $e");
      return const Left("Failed to decode cached products");
    }
  }

  @override
  Future<Either<String, void>> cacheProducts(List<Product> products) async {
    try {
      final jsonString =
          json.encode(products.map((product) => product.toJson()).toList());
      sl<SharedPreferences>().setString('products', jsonString);
      LoggerHelper.info("Cached products in Shared Preferences");
      return const Right(null);
    } catch (e) {
      LoggerHelper.error("Failed to cache products: $e");
      return const Left("Failed to cache products");
    }
  }

  @override
  Future<Either<String, List<FavouriteData>>> getUserFavourites() async {
    try {
      final jsonString = sl<SharedPreferences>().getString('favourites');
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        final List<FavouriteData> favourites =
            jsonList.map((json) => FavouriteData.fromJson(json)).toList();
        LoggerHelper.info("Loaded cached favourites from Shared Preferences");
        return Right(favourites);
      } else {
        LoggerHelper.warning("No cached favourites found");
        return const Left("No cached favourites found");
      }
    } catch (e) {
      LoggerHelper.error("Failed to decode cached favourites: $e");
      return const Left("Failed to decode cached favourites");
    }
  }

  @override
  Future<Either<String, void>> cacheUserFavourites(
      List<FavouriteData> favourites) async {
    try {
      final jsonString = json
          .encode(favourites.map((favourite) => favourite.toJson()).toList());
      sl<SharedPreferences>().setString('favourites', jsonString);
      LoggerHelper.info("Cached favourites in Shared Preferences");
      return const Right(null);
    } catch (e) {
      LoggerHelper.error("Failed to cache favourites: $e");
      return const Left("Failed to cache favourites");
    }
  }

  @override
  Future<Either<String, void>> cacheProfile(ProfileData profile) async {
    try {
      final jsonString = json.encode(profile.toJson());
      sl<SharedPreferences>().setString('profile', jsonString);
      LoggerHelper.info("Cached profile in Shared Preferences");
      return const Right(null);
    } catch (e) {
      LoggerHelper.error("Failed to cache profile: $e");
      return const Left("Failed to cache profile");
    }
  }

  @override
  Future<Either<String, ProfileData>> getProfile() async {
    try {
      final jsonString = sl<SharedPreferences>().getString('profile');
      if (jsonString != null) {
        final profile = ProfileData.fromJson(json.decode(jsonString));
        LoggerHelper.info("Loaded cached profile from Shared Preferences");
        return Right(profile);
      } else {
        LoggerHelper.warning("No cached profile found");
        return const Left("No cached profile found");
      }
    } catch (e) {
      LoggerHelper.error("Failed to decode cached profile: $e");
      return const Left("Failed to decode cached profile");
    }
  }

  @override
  Future<void> addToCart(String token, CartItem item) async {
    final cart = await _getCart(token);
    cart.add(item);
    await _saveCart(token, cart);
  }

  @override
  Future<void> removeFromCart(String token, String itemId) async {
    final cart = await _getCart(token);
    cart.removeWhere((item) => item.id.toString() == itemId);
    await _saveCart(token, cart);
  }

  @override
  Future<List<CartItem>> getCartItems(String token) async {
    return await _getCart(token);
  }

  @override
  Future<void> clearCart(String token) async {
    await sl<SharedPreferences>().remove(_getCartKey(token));
  }

  @override
  Future<void> updateQuantity(String token, String itemId, int quantity) async {
    final cart = await _getCart(token);
    final index = cart.indexWhere((item) => item.id.toString() == itemId);
    if (index != -1) {
      cart[index] = cart[index].copyWith(quantity: quantity);
      await _saveCart(token, cart);
    }
  }

  Future<List<CartItem>> _getCart(String token) async {
    final cartString = sl<SharedPreferences>().getString(_getCartKey(token));
    if (cartString != null) {
      return CartItem.decodeList(cartString);
    }
    return [];
  }

  Future<void> _saveCart(String token, List<CartItem> cart) async {
    final cartString = CartItem.encodeList(cart);
    await sl<SharedPreferences>().setString(_getCartKey(token), cartString);
  }

  String _getCartKey(String token) => 'cart_$token';
}
