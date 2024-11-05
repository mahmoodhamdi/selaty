import 'package:selaty/features/home/data/models/favourite_item.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<FavoriteItem> items;

  FavoritesLoaded(this.items);
}

class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError(this.message);
}
