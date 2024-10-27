import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/usecase/usecase.dart';
import 'package:selaty/features/home/data/models/slider_response.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';

class GetSliderImagesUseCase
    extends UseCase<Either<String, List<SliderResponseData>>, NoParams> {
  @override
  Future<Either<String, List<SliderResponseData>>> call(
      {NoParams? param}) async {
    return await sl<HomeRepo>().getSliderImages();
  }
}
