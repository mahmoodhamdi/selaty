import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/usecase/usecase.dart';
import 'package:selaty/features/auth/data/models/login_req_body.dart';
import 'package:selaty/features/auth/domain/repository/auth_repo.dart';

class LoginUsecase extends UseCase<Either<dynamic, dynamic>, LoginParams> {
  @override
  Future<Either<dynamic, dynamic>> call({LoginParams? param}) async {
    // Ensure param is not null
    if (param == null) {
      throw ArgumentError('LoginParams cannot be null');
    }
    return await sl<AuthRepo>().login(loginReqBody: param.loginParams);
  }
}

class LoginParams {
  final LoginReqBody loginParams;

  LoginParams({required this.loginParams});
}
