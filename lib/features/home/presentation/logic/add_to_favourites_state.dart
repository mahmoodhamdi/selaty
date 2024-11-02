import 'package:equatable/equatable.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/data/models/get_user_favourite_response.dart';

class AddToFavouritesState extends Equatable {
  final AddToFavouritesStatus status;
  final String? message;
  final List<FavouriteData> favouriteList;

  const AddToFavouritesState({
    this.status = AddToFavouritesStatus.initial,
    this.message,
    this.favouriteList = const [],
  });

  @override
  List<Object?> get props => [status, message, favouriteList];

  AddToFavouritesState copyWith({
    AddToFavouritesStatus? status,
    String? message,
    List<FavouriteData>? favouriteList,
  }) {
    return AddToFavouritesState(
      status: status ?? this.status,
      message: message,
      favouriteList: favouriteList ?? this.favouriteList,
    );
  }
}
