import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/usecase/usecase.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';

class GetProductsUsecase
    extends UseCase<Either<String, List<Product>>, GetProductsParams> {
  @override
  Future<Either<String, List<Product>>> call({GetProductsParams? param}) async {
    final GetProductsParams params =
        param ?? GetProductsParams(page: 1); // Provide a default page if needed
    return await sl<HomeRepo>().getProducts(page: params.page);
  }
}

class GetProductsParams {
  final int page;

  GetProductsParams({required this.page});
}
