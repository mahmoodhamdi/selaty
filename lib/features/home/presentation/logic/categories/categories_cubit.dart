import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/core/usecase/usecase.dart';
import 'package:selaty/features/home/data/models/categories_response.dart';
import 'package:selaty/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:selaty/features/home/presentation/logic/categories/categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {

  CategoriesCubit()
      : super(const CategoriesState());

  Future<void> fetchCategories() async {
    emit(state.copyWith(status: CategoriesStatus.loading));

    final Either<String, List<Category>> result =
        await sl<GetCategoriesUsecase>().call(param: NoParams());

    result.fold(
      (error) => emit(state.copyWith(
          status: CategoriesStatus.failure, errorMessage: error)),
      (categories) => emit(state.copyWith(
          status: CategoriesStatus.success, categories: categories)),
    );
  }
}
