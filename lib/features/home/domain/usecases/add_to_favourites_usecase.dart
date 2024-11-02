import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/usecase/usecase.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';

class AddToFavouritesUsecase extends UseCase<Either<String, String>, int> {
  @override
  Future<Either<String, String>> call({int? param}) async {
    return sl<HomeRepo>().addToFavourites(productId: param!);
  }
}
