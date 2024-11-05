import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/home/data/models/favourite_item.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';

class AddToFavoritesUseCase {
  Future<void> call(FavoriteItem item) async {
    await sl<HomeRepo>().addToFavorites(item);
  }
}
