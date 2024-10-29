import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/helpers/logger_helper.dart';
import 'package:selaty/features/home/data/models/categories_response.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/data/models/slider_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeLocalDataSource {
  Future<Either<String, List<SliderResponseData>>> getSliderImages();
  Future<Either<String, void>> cacheSliderImages(
      List<SliderResponseData> images);
  Future<Either<String, List<Category>>> getCategories();
  Future<Either<String, void>> cacheCategories(List<Category> categories);
  Future<Either<String, List<Product>>> getProducts();
  Future<Either<String, void>> cacheProducts(List<Product> products);

  Future<Either<String, void>> clearCache();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<Either<String, List<SliderResponseData>>> getSliderImages() async {
    final jsonString = sl<SharedPreferences>().getString('slider_images');
    if (jsonString != null) {
      try {
        final List<dynamic> jsonList = json.decode(jsonString);
        final List<SliderResponseData> images =
            jsonList.map((json) => SliderResponseData.fromJson(json)).toList();
        LoggerHelper.info(
            "Loaded cached slider images from Shared Preferences");
        return Right(images);
      } catch (e) {
        LoggerHelper.error("Failed to decode cached images: $e");
        return const Left("Failed to decode cached images");
      }
    } else {
      LoggerHelper.warning("No cached images found");
      return const Left("No cached images found");
    }
  }

  @override
  Future<Either<String, void>> cacheSliderImages(
      List<SliderResponseData> sliderResponseList) async {
    try {
      final jsonString = json
          .encode(sliderResponseList.map((image) => image.toJson()).toList());
      await sl<SharedPreferences>().setString('slider_images', jsonString);
      LoggerHelper.info("Cached slider images in Shared Preferences");
      return const Right(null);
    } catch (e) {
      LoggerHelper.error("Failed to cache images: $e");
      return const Left("Failed to cache images");
    }
  }

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
}
