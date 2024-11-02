// Cubit to manage the Add to Favourites functionality.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/data/models/get_user_favourite_response.dart';
import 'package:selaty/features/home/domain/usecases/add_to_favourites_usecase.dart';
import 'package:selaty/features/home/presentation/logic/add_to_favourites_state.dart';

class AddToFavouritesCubit extends Cubit<AddToFavouritesState> {
  AddToFavouritesCubit(List<FavouriteData> initialFavourites)
      : super(AddToFavouritesState(favouriteList: initialFavourites));

  Future<void> addToFavourites(int productId) async {
    emit(state.copyWith(status: AddToFavouritesStatus.loading));

    final result = await sl<AddToFavouritesUsecase>().call(param: productId);

    result.fold(
      (error) => emit(state.copyWith(
          status: AddToFavouritesStatus.failure, message: error)),
      (successMessage) {
        final updatedFavourites = List<FavouriteData>.from(state.favouriteList);

        final index = updatedFavourites
            .indexWhere((favourite) => favourite.product?.id == productId);
        if (index != -1) {
          updatedFavourites.removeAt(index);
        }

        emit(state.copyWith(
          status: AddToFavouritesStatus.success,
          message: successMessage,
          favouriteList: updatedFavourites,
        ));
      },
    );
  }
}
