import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/usecase/usecase.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart'; // Import your Product model

class GetCategoryNamesForProductsUsecase extends UseCase<
    Either<String, List<String>>, GetCategoryNamesForProductsParams> {
  @override
  Future<Either<String, List<String>>> call(
      {GetCategoryNamesForProductsParams? param}) async {
    return await sl<HomeRepo>().getCategoryNamesForProducts(param!.products);
  }
}

class GetCategoryNamesForProductsParams {
  final List<Product> products;

  GetCategoryNamesForProductsParams({required this.products});
}
