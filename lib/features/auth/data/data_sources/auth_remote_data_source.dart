import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:selaty/core/constants/api_constants.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/helpers/dio_exception_helper.dart';
import 'package:selaty/core/helpers/platform_exception_helper.dart';
import 'package:selaty/core/network/dio_client.dart';
import 'package:selaty/features/auth/data/models/login_req_body.dart';
import 'package:selaty/features/auth/data/models/login_response.dart';
import 'package:selaty/features/auth/data/models/register_req_body.dart';
import 'package:selaty/features/auth/data/models/register_response.dart';
import 'package:selaty/features/auth/data/models/send_otp_req_body.dart';
import 'package:selaty/features/auth/data/models/send_otp_response.dart';

abstract class AuthRemoteDataSource {
  Future<Either<String, RegisterUserData>> register(
      {required RegisterReqBody registerReqBody});
  Future<Either<String, LoginUserData>> login(
      {required LoginReqBody loginReqBody});
  Future<Either> sendOtp({required SendOtpReqBody forgetPasswordReqBody});
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
      // Handle the DioException using DioExceptionHelper
      return Left(DioExceptionHelper.handleDioError(e));
    } on PlatformException catch (e) {
      // Handle the PlatformException using PlatformExceptionHelper
      return Left(PlatformExceptionHelper.handlePlatformError(e));
    } catch (e) {
      return Left(
          'حدث خطأ غير متوقع: $e'); // Arabic for "An unexpected error occurred"
    }
  }

  @override
  Future<Either<String, LoginUserData>> login(
      {required LoginReqBody loginReqBody}) async {
    try {
      var response = await sl<DioClient>().post(
        ApiConstants.loginUrl,
        data: loginReqBody.toJson(),
      );

      LoginResponse loginResponse = LoginResponse.fromJson(response.data);

      if (loginResponse.status) {
        return Right(loginResponse.data!);
      } else {
        return Left(loginResponse.message);
      }
    } on DioException catch (e) {
      // Handle the DioException using DioExceptionHelper
      return Left(DioExceptionHelper.handleDioError(e));
    } on PlatformException catch (e) {
      // Handle the PlatformException using PlatformExceptionHelper
      return Left(PlatformExceptionHelper.handlePlatformError(e));
    } catch (e) {
      return Left(
          'حدث خطأ غير متوقع: $e'); // Arabic for "An unexpected error occurred"
    }
  }

  @override

  Future<Either<String, SendOtpResponseData>> sendOtp(
      {required SendOtpReqBody forgetPasswordReqBody}) async {
    try {
      var response = await sl<DioClient>().post(ApiConstants.forgotPasswordUrl,
          data: forgetPasswordReqBody.toJson());
      SendOtpResponse forgetPassResponse =
          SendOtpResponse.fromJson(response.data);
      if (forgetPassResponse.status) {
        return Right(forgetPassResponse.data!);
      } else {
        return Left(forgetPassResponse.message);
      }
    } on DioException catch (e) {
      // Handle the DioException using DioExceptionHelper
      return Left(DioExceptionHelper.handleDioError(e));
    } on PlatformException catch (e) {
      // Handle the PlatformException using PlatformExceptionHelper
      return Left(PlatformExceptionHelper.handlePlatformError(e));
    } catch (e) {
      return Left(
          'حدث خطأ غير متوقع: $e'); // Arabic for "An unexpected error occurred"
    }
  }
}
