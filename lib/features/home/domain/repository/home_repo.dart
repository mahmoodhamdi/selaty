import 'package:dartz/dartz.dart';
import 'package:selaty/features/home/data/models/slider_response.dart';

abstract class HomeRepo {
  Future<Either<String, List<SliderResponseData>>> getSliderImages();
}
