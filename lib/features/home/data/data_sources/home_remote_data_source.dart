  import 'package:dartz/dartz.dart';
  import 'package:dio/dio.dart';
  import 'package:flutter/services.dart';
  import 'package:selaty/core/constants/api_constants.dart';
  import 'package:selaty/core/depandancy_injection/service_locator.dart';
  import 'package:selaty/core/helpers/dio_exception_helper.dart';
  import 'package:selaty/core/helpers/platform_exception_helper.dart';
  import 'package:selaty/core/network/dio_client.dart';
  import 'package:selaty/features/home/data/models/slider_response.dart';

  abstract class HomeRemoteDataSource {
    Future<Either<String, List<SliderResponseData>>> getSliderImages();
  }

  class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
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
        // Handle the DioException using DioExceptionHelper
        return Left(DioExceptionHelper.handleDioError(e));
      } on PlatformException catch (e) {
        // Handle the PlatformException using PlatformExceptionHelper
        return Left(PlatformExceptionHelper.handlePlatformError(e));
      } catch (e) {
        return Left(
            'حدث خطأ غير متوقع: $e'); // Arabic for "An unexpected error occurred"
      }
    }
  }
