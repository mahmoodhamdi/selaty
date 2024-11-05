import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/home/data/models/cart.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';

class GetCartItemsUseCase {
  Future<List<CartItem>> call() => sl<HomeRepo>().getCartItems();
}
