import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/auth/data/data_sources/auth_remote_data_source/auth_remote_data_source.dart';
import 'package:selaty/features/auth/data/models/register_req_body.dart';
import 'package:selaty/features/auth/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either> register({required RegisterReqBody registerReqBody}) async {
    Either result = await sl<AuthRemoteDataSource>()
        .register(registerReqBody: registerReqBody);
   return result.fold(
      (error) {
        return Left(error);
      },
      (success) {
        return Right(success);
      },
    );
  }
}
