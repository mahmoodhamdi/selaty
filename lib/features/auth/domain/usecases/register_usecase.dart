import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/usecase/usecase.dart';
import 'package:selaty/features/auth/data/models/register_req_body.dart';
import 'package:selaty/features/auth/domain/repository/auth_repo.dart';

class RegisterUseCase extends UseCase<Either, RegisterParams> {
  @override
  Future<Either<dynamic, dynamic>> call({RegisterParams? param}) async {
    if (param == null) throw ArgumentError('RegisterParams cannot be null');
    return await sl<AuthRepo>()
        .register(registerReqBody: param.registerReqBody);
  }
}

class RegisterParams {
  final RegisterReqBody registerReqBody;

  RegisterParams({required this.registerReqBody});
}
