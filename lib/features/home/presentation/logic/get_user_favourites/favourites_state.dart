import 'package:equatable/equatable.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/data/models/get_user_favourite_response.dart';

class FavouritesState extends Equatable {
  final FavouritesStatus status;
  final String? message;
  final List<FavouriteData> favouriteList;

  const FavouritesState({
    this.status = FavouritesStatus.initial,
    this.message,
    this.favouriteList = const [],
  });

  @override
  List<Object?> get props => [status, message, favouriteList];

  FavouritesState copyWith({
    FavouritesStatus? status,
    String? message,
    List<FavouriteData>? favouriteList,
  }) {
    return FavouritesState(
      status: status ?? this.status,
      message: message,
      favouriteList: favouriteList ?? this.favouriteList,
    );
  }
}
