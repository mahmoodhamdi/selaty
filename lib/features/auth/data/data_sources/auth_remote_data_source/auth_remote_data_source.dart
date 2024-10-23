import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:selaty/core/constants/api_constants.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/network/dio_client.dart';
import 'package:selaty/features/auth/data/models/login_req_body.dart';
import 'package:selaty/features/auth/data/models/login_response.dart';
import 'package:selaty/features/auth/data/models/register_req_body.dart';
import 'package:selaty/features/auth/data/models/register_response.dart';

abstract class AuthRemoteDataSource {
  Future<Either<String, RegisterUserData>> register(
      {required RegisterReqBody registerReqBody});
  Future<Either<String, LoginUserData>> login(
      {required LoginReqBody loginReqBody});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Either<String, RegisterUserData>> register(
      {required RegisterReqBody registerReqBody}) async {
    try {
      var response = await sl<DioClient>().post(
        ApiConstants.registerUrl,
        data: registerReqBody.toJson(),
      );

      RegisterResponse registerResponseModel =
          RegisterResponse.fromJson(response.data);

      if (registerResponseModel.status) {
        return Right(registerResponseModel.data!);
      } else {
        return Left(registerResponseModel.errorMessage);
      }
    } on DioException catch (e) {
      // Handle specific Dio errors if needed
      return Left('${e.message}');
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }

  @override
  Future<Either<String, LoginUserData>> login(
      {required LoginReqBody loginReqBody}) async {
    try {
      var response = await sl<DioClient>()
          .post(ApiConstants.loginUrl, data: loginReqBody.toJson());
      LoginResponse loginResponse = LoginResponse.fromJson(response.data);
      if (loginResponse.status) {
        return Right(loginResponse.data!);
      } else {
        return Left(loginResponse.message);
      }
    } on DioException catch (e) {
      return Left('${e.message}');
    } catch (e) {
      return Left('An unexpected error occurred: $e');
    }
  }
}
