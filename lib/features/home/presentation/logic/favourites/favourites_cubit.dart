import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/helpers/logger_helper.dart';
import 'package:selaty/features/home/data/models/favourite_item.dart';
import 'package:selaty/features/home/domain/usecases/add_to_favourites_usecase.dart';
import 'package:selaty/features/home/domain/usecases/clear_favorite_usecase.dart';
import 'package:selaty/features/home/domain/usecases/get_user_favourites_usecase.dart';
import 'package:selaty/features/home/domain/usecases/remove_from_favorites_use_case.dart';
import 'package:selaty/features/home/presentation/logic/favourites/favourites_state.dart';

class FavoriteCubit extends Cubit<FavoritesState> {
  final AddToFavoritesUseCase addToFavorites;
  final RemoveFromFavoritesUseCase removeFromFavorites;
  final GetFavoriteItemsUseCase getFavoriteItems;
  final ClearFavoritesUseCase clearFavorites;

  FavoriteCubit({
    required this.addToFavorites,
    required this.removeFromFavorites,
    required this.getFavoriteItems,
    required this.clearFavorites,
  }) : super(FavoritesInitial());

  /// Load favorite items
  Future<void> loadFavoriteItems() async {
    LoggerHelper.info("Loading favorite items");
    emit(FavoritesLoading());
    try {
      final items = await getFavoriteItems();
      LoggerHelper.debug("Favorite items loaded: $items");
      emit(FavoritesLoaded(items));
    } catch (e) {
      LoggerHelper.error("Error loading favorite items", e);
      emit(FavoritesError(e.toString()));
    }
  }

  /// Add item to favorites
  Future<void> addFavorite(FavoriteItem item) async {
    LoggerHelper.info("Adding item to favorites: ${item.name}");
    try {
      await addToFavorites.call(item);
      LoggerHelper.debug("Item added to favorites: ${item.name}");
      loadFavoriteItems(); // Reload items after adding
    } catch (e) {
      LoggerHelper.error("Error adding item to favorites: ${item.name}", e);
      emit(FavoritesError(e.toString()));
    }
  }

  /// Remove item from favorites
  Future<void> removeFavorite(String itemId) async {
    LoggerHelper.info("Removing item from favorites: ID $itemId");
    try {
      await removeFromFavorites.call(itemId);
      LoggerHelper.debug("Item removed from favorites: ID $itemId");
      loadFavoriteItems(); // Reload items after removal
    } catch (e) {
      LoggerHelper.error("Error removing item from favorites: ID $itemId", e);
      emit(FavoritesError(e.toString()));
    }
  }

  /// Clear all favorites
  Future<void> clear() async {
    LoggerHelper.info("Clearing all items in the favorites");
    try {
      await clearFavorites.call();
      LoggerHelper.debug("Favorites cleared");
      emit(FavoritesLoaded([])); // Update UI to show empty favorites
    } catch (e) {
      LoggerHelper.error("Error clearing favorites", e);
      emit(FavoritesError(e.toString()));
    }
  }
}
