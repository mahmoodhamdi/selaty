import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/helpers/logger_helper.dart';
import 'package:selaty/features/home/data/models/categories_response.dart';
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
  Future<Either<String, List<FavouriteData>>> getUserFavourites();
  Future<Either<String, ProfileData>> getProfile();
  Future<Either<String, void>> cacheProfile(ProfileData profile);
  Future<Either<String, void>> clearCache();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  
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

  @override
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
  Future<Either<String, void>> cacheProfile(ProfileData profile)async {
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
  Future<Either<String, ProfileData>> getProfile() async{
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
}
