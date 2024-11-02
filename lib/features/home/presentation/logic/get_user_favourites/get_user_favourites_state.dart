import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/data/models/get_user_favourite_response.dart';

class GetUserFavouritesState {
  final GetUserFavouritesStatus status;
  final List<FavouriteData>? favourites;
  final String? errorMessage;

  const GetUserFavouritesState({
    required this.status,
    this.favourites,
    this.errorMessage,
  });

  GetUserFavouritesState copyWith({
    GetUserFavouritesStatus? status,
    List<FavouriteData>? favourites,
    String? errorMessage,
  }) {
    return GetUserFavouritesState(
      status: status ?? this.status,
      favourites: favourites ?? this.favourites,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory GetUserFavouritesState.initial() {
    return const GetUserFavouritesState(
      status: GetUserFavouritesStatus.initial,
    );
  }
}
