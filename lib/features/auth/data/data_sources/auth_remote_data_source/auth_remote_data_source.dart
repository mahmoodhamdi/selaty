import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:selaty/core/constants/api_constants.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/network/dio_client.dart';
import 'package:selaty/features/auth/data/models/register_req_body.dart';
import 'package:selaty/features/auth/data/models/register_response.dart';

abstract class AuthRemoteDataSource {
  Future<Either> register({required RegisterReqBody registerReqBody});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Either> register({required RegisterReqBody registerReqBody}) async {
    try {
      var response = await sl<DioClient>().post(
        ApiConstants.registerUrl,
        data: registerReqBody.toJson(),
      );
      RegisterResponse registerResponseModel =
          RegisterResponse.fromJson(response.data);
      if (registerResponseModel.status) {
        return Right(registerResponseModel.data);
      } else {
        return Left(registerResponseModel.errorMessage);
      }
    } on DioException catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
