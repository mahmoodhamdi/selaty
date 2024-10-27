import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:selaty/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:selaty/features/auth/data/models/login_req_body.dart';
import 'package:selaty/features/auth/data/models/login_response.dart';
import 'package:selaty/features/auth/data/models/register_req_body.dart';
import 'package:selaty/features/auth/data/models/send_otp_req_body.dart';
import 'package:selaty/features/auth/data/models/send_otp_response.dart';
import 'package:selaty/features/auth/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either> register({required RegisterReqBody registerReqBody}) async {
    final result = await sl<AuthRemoteDataSource>()
        .register(registerReqBody: registerReqBody);
    return result.fold(
      (error) => Left(error),
      (userData) async {
        // If registration is successful, you might want to automatically log in
        // or handle the registration response differently
        return Right(userData);
      },
    );
  }

  @override
  Future<Either> login({required LoginReqBody loginReqBody}) async {
    final result =
        await sl<AuthRemoteDataSource>().login(loginReqBody: loginReqBody);
    return result.fold(
      (error) => Left(error),
      (userData) async {
        // Cache user data locally on successful login
        await sl<AuthLocalDataSource>().cacheUserData(userData);
        // If your API returns a token, save it
        await sl<AuthLocalDataSource>().saveToken(userData.token);
        return Right(userData);
      },
    );
  }

  // You might want to add these additional methods to your AuthRepo interface
  @override
  Future<void> logout() async {
    await sl<AuthLocalDataSource>().clearUserData();
  }

  @override
  Future<LoginUserData?> getCachedUser() async {
    return await sl<AuthLocalDataSource>().getCachedUserData();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthLocalDataSource>().isLoggedIn();
  }

  @override
  Future<Either<String,SendOtpResponseData>> sendOtp(
      {required SendOtpReqBody forgetPasswordReqBody}) async {
    final result = await sl<AuthRemoteDataSource>()
        .sendOtp(forgetPasswordReqBody: forgetPasswordReqBody);
    return result.fold(
      (error) => Left(error),
      (success) async {
        
        
        return Right(success);
      },
    );
  }
}
