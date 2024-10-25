import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/usecase/usecase.dart';
import 'package:selaty/features/auth/domain/repository/auth_repo.dart';

class LogoutUsecase extends UseCase<void, NoParams> {
  @override
  Future<void> call({NoParams? param}) async {
    await sl<AuthRepo>().logout();
  }
}
