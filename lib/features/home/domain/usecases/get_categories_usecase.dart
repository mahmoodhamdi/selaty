import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/usecase/usecase.dart';
import 'package:selaty/features/home/data/models/categories_response.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';

class GetCategoriesUsecase
    extends UseCase<Either<String, List<Category>>, NoParams> {
  @override
  Future<Either<String, List<Category>>> call({NoParams? param}) async {
    return await sl<HomeRepo>().getCategories();
  }
}
