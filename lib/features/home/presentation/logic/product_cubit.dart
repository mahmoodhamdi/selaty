import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/domain/usecases/get_products_usecase.dart';
import 'package:selaty/features/home/presentation/logic/product_state.dart';

class ProductCubit extends Cubit<ProductState> {

  ProductCubit()
      : super(const ProductState());

   Future<void> fetchProducts(int page) async {
    emit(state.copyWith(status: ProductStatus.loading)); // Start loading

    final Either<String, List<Product>> result =
        await sl<GetProductsUsecase>().call(param: GetProductsParams(page: page));

    result.fold(
      (error) => emit(state.copyWith(
          status: ProductStatus.failure, errorMessage: error)), // Handle error
      (products) => emit(state.copyWith(
          status: ProductStatus.success, products: products)), // Handle success
    );
  }
}
