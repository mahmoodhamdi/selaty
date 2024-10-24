import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/usecase/usecase.dart';
import 'package:selaty/features/auth/data/models/login_req_body.dart';
import 'package:selaty/features/auth/domain/repository/auth_repo.dart';

class LoginUsecase extends UseCase<Either, LoginParms> {
  @override
  Future<Either<dynamic, dynamic>> call({LoginParms? param}) async {
    if (param == null) throw ArgumentError('RegisterParams cannot be null');

    final Either result =
        await sl<AuthRepo>().login(loginReqBody: param.loginReqBody);
    return result.fold((error) => Left(error), (success) => Right(success));
  }
}

class LoginParms {
  final LoginReqBody loginReqBody;

  LoginParms({required this.loginReqBody});
}
