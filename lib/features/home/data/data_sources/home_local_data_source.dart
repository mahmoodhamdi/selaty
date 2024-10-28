import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/helpers/logger_helper.dart';
import 'package:selaty/features/home/data/models/slider_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeLocalDataSource {
  Future<Either<String, List<SliderResponseData>>> getSliderImages();
  Future<Either<String, void>> cacheSliderImages(
      List<SliderResponseData> images);
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
}
