import 'package:equatable/equatable.dart';
import 'package:selaty/core/enums/status.dart';
class AddToFavouritesState extends Equatable {
  final AddToFavouritesStatus status;
  final String? message;
  final List<int>
      favouriteIds; // Or List<FavouriteData> if you need full objects

  const AddToFavouritesState({
    this.status = AddToFavouritesStatus.initial,
    this.message,
    this.favouriteIds = const [], // Initialize with an empty list
  });

  @override
  List<Object?> get props => [status, message, favouriteIds];

  // CopyWith method to create a new state with updated fields.
  AddToFavouritesState copyWith({
    AddToFavouritesStatus? status,
    String? message,
    List<int>? favouriteIds,
  }) {
    return AddToFavouritesState(
      status: status ?? this.status,
      message: message,
      favouriteIds: favouriteIds ?? this.favouriteIds,
    );
  }
}
