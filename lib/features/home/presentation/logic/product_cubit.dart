import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/domain/usecases/get_products_usecase.dart';
import 'package:selaty/features/home/presentation/logic/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductState());

  // Keep track of the current page and whether there's more data to load
  int _currentPage = 1;
  bool _hasMoreData = true;

  Future<void> fetchProducts({bool loadMore = false}) async {
    // If loading more and either already loading or no more data, return
    if (loadMore && (state.status == ProductStatus.loading || !_hasMoreData)) {
      return;
    }

    // If not loading more, reset pagination
    if (!loadMore) {
      _currentPage = 1;
      _hasMoreData = true;
      emit(state.copyWith(status: ProductStatus.loading));
    } else {
      // If loading more, show loading more status
      emit(state.copyWith(status: ProductStatus.loadingMore));
    }

    final Either<String, List<Product>> result = await sl<GetProductsUsecase>()
        .call(param: GetProductsParams(page: _currentPage));

    result.fold(
      (error) => emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: error,
      )),
      (newProducts) {
        // If no new products, mark as no more data
        if (newProducts.isEmpty) {
          _hasMoreData = false;
          emit(state.copyWith(
            status: ProductStatus.success,
          ));
          return;
        }

        final List<Product> updatedProducts = loadMore
            ? [...(state.products ?? []), ...newProducts]
            : newProducts;

        _currentPage++;

        emit(state.copyWith(
          status: ProductStatus.success,
          products: updatedProducts,
          hasMoreData: _hasMoreData,
        ));
      },
    );
  }

  // Method to load more products
  Future<void> loadMore() async {
    await fetchProducts(loadMore: true);
  }
}
