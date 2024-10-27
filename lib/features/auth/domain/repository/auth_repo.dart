import 'package:dartz/dartz.dart';
import 'package:selaty/features/auth/data/models/change_password_req_body.dart';
import 'package:selaty/features/auth/data/models/change_password_response.dart';
import 'package:selaty/features/auth/data/models/login_req_body.dart';
import 'package:selaty/features/auth/data/models/login_response.dart';
import 'package:selaty/features/auth/data/models/register_req_body.dart';
import 'package:selaty/features/auth/data/models/send_otp_req_body.dart';
import 'package:selaty/features/auth/data/models/send_otp_response.dart';

abstract class AuthRepo {
  Future<Either> register({required RegisterReqBody registerReqBody});
  Future<Either> login({required LoginReqBody loginReqBody});
  Future<void> logout();
  Future<LoginUserData?> getCachedUser();
  Future<bool> isLoggedIn();
  Future<Either<String, SendOtpResponseData>> sendOtp(
      {required SendOtpReqBody forgetPasswordReqBody});
  Future<Either<String, ChangePasswordResponseData>> setNewPassword(
      {required ChangePasswordReqBody changePasswordReqBody});
}
