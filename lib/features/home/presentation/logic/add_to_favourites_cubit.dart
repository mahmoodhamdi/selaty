// Cubit to manage the Add to Favourites functionality.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/domain/usecases/add_to_favourites_usecase.dart';
import 'package:selaty/features/home/presentation/logic/add_to_favourites_state.dart';
class AddToFavouritesCubit extends Cubit<AddToFavouritesState> {
  AddToFavouritesCubit() : super(const AddToFavouritesState());

  Future<void> addToFavourites(int productId) async {
    emit(state.copyWith(status: AddToFavouritesStatus.loading));

    final result = await sl<AddToFavouritesUsecase>().call(param: productId);

    result.fold(
      (error) => emit(state.copyWith(
          status: AddToFavouritesStatus.failure, message: error)),
      (successMessage) {
        final updatedFavourites = List<int>.from(state.favouriteIds);

        if (updatedFavourites.contains(productId)) {
          updatedFavourites.remove(productId);
        } else {
          updatedFavourites.add(productId);
        }

        emit(state.copyWith(
          status: AddToFavouritesStatus.success,
          message: successMessage,
          favouriteIds: updatedFavourites,
        ));
      },
    );
  }
}
