import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';

class ClearCartUseCase {


  Future<void> call() => sl<HomeRepo>().clearCart();
}
