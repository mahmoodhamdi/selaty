import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';

class ClearFavoritesUseCase {
  Future<void> call() async {
    await sl<HomeRepo>().clearFavorites();
  }
}
