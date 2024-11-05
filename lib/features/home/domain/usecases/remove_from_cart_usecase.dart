import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';

class RemoveFromCartUseCase {
  Future<void> call(String itemId) => sl<HomeRepo>().removeFromCart(itemId);
}
