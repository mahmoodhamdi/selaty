import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';

class UpdateQuantityUseCase {
  Future<void> call(String itemId, int quantity) =>
      sl<HomeRepo>().updateQuantity(itemId, quantity);
}
