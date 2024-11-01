import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/usecase/usecase.dart';
import 'package:selaty/features/home/data/models/get_user_favourite_response.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';

class GetUserFavouritesUsecase
    extends UseCase<Either<String, List<FavouriteData>>, NoParams> {
  @override
  Future<Either<String, List<FavouriteData>>> call({NoParams? param}) async {
    final result = await sl<HomeRepo>().getUserFavourites();
    return result.fold(
      (error) => Left(error),
      (favourites) => Right(favourites),
    );
  }
}
