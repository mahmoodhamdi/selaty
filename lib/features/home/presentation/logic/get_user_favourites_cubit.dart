import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/domain/usecases/get_user_favourites_usecase.dart';
import 'package:selaty/features/home/presentation/logic/get_user_favourites_state.dart';

class GetUserFavouritesCubit extends Cubit<GetUserFavouritesState> {
  GetUserFavouritesCubit() : super(GetUserFavouritesState.initial());

  Future<void> fetchUserFavourites() async {
    emit(state.copyWith(status: GetUserFavouritesStatus.loading));

    final result = await sl<GetUserFavouritesUsecase>().call();

    result.fold(
      (error) => emit(state.copyWith(
        status: GetUserFavouritesStatus.error,
        errorMessage: error,
      )),
      (favourites) => emit(state.copyWith(
        status: GetUserFavouritesStatus.success,
        favourites: favourites,
      )),
    );
  }
}
