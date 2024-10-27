import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:selaty/features/home/data/models/slider_response.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  @override
  Future<Either<String, List<SliderResponseData>>> getSliderImages() async {
    final result = await sl<HomeRemoteDataSource>().getSliderImages();
    return result.fold(
      (error) => Left(error),
      (sliderResponse) async {
        return Right(sliderResponse);
      },
    );
  }
}
