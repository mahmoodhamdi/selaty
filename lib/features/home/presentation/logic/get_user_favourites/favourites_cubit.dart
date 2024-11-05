import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/data/models/get_user_favourite_response.dart';
import 'package:selaty/features/home/domain/usecases/add_to_favourites_usecase.dart';
import 'package:selaty/features/home/domain/usecases/get_user_favourites_usecase.dart';
import 'package:selaty/features/home/presentation/logic/get_user_favourites/favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit(List<FavouriteData> initialFavourites)
      : super(FavouritesState(favouriteList: initialFavourites));

  Future<void> addToFavourites(int productId) async {
    emit(state.copyWith(status: FavouritesStatus.addingToFavouritesLoading));

    final result = await sl<AddToFavouritesUsecase>().call(param: productId);

    result.fold(
      (error) => emit(state.copyWith(
          status: FavouritesStatus.addingToFavouritesFailure, message: error)),
      (successMessage) {
        final updatedFavourites = List<FavouriteData>.from(state.favouriteList);
        final index = updatedFavourites
            .indexWhere((favourite) => favourite.product?.id == productId);

        if (index != -1) {
          updatedFavourites.removeAt(index);
        }

        emit(state.copyWith(
          status: FavouritesStatus.addingToFavouritesSuccess,
          message: successMessage,
          favouriteList: updatedFavourites,
        ));
      },
    );
  }

  Future<void> fetchUserFavourites() async {
    emit(state.copyWith(status: FavouritesStatus.fetchingFavouritesLoading));

    final result = await sl<GetUserFavouritesUsecase>().call();

    result.fold(
      (error) => emit(state.copyWith(
        status: FavouritesStatus.fetchingFavouritesFailure,
        message: error,
      )),
      (favourites) => emit(state.copyWith(
        status: FavouritesStatus.fetchingFavouritesSuccess,
        favouriteList: favourites,
      )),
    );
  }
}
