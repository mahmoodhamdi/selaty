import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';

class RemoveFromFavoritesUseCase {
  Future<void> call(String itemId) async {
    await sl<HomeRepo>().removeFromFavorites(itemId);
  }
}
