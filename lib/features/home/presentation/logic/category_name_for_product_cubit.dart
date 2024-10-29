import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/data/models/product_reesponse_model.dart';
import 'package:selaty/features/home/domain/usecases/get_category_name_for_product_usecase.dart';
import 'package:selaty/features/home/presentation/logic/category_name_for_product_state.dart';

class CategoryNameCubit extends Cubit<CategoryNameState> {
  CategoryNameCubit()
      : super(CategoryNameState(
            status: CategoryNameStatus.initial, categoryNames: []));

  Future<void> fetchCategoryNames(List<Product> products) async {
    emit(state.copyWith(status: CategoryNameStatus.loading));

    final result = await sl<GetCategoryNamesForProductsUsecase>().call(
      param: GetCategoryNamesForProductsParams(products: products),
    );

    result.fold(
      (error) {
        emit(state.copyWith(status: CategoryNameStatus.failure));
      },
      (categoryNames) {
        emit(state.copyWith(
            status: CategoryNameStatus.success, categoryNames: categoryNames));
      },
    );
  }
}
