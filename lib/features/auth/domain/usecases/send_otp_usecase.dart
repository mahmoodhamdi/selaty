import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/usecase/usecase.dart';
import 'package:selaty/features/auth/data/models/send_otp_req_body.dart';
import 'package:selaty/features/auth/domain/repository/auth_repo.dart';

class SendOtpUsecase extends UseCase<Either, ForgetPassParms> {
  @override
  Future<Either<dynamic, dynamic>> call({ForgetPassParms? param}) async {
    if (param == null) throw ArgumentError('RegisterParams cannot be null');

    return await sl<AuthRepo>()
        .sendOtp(forgetPasswordReqBody: param.forgetPasswordReqBody);
  }
}

class ForgetPassParms {
  final SendOtpReqBody forgetPasswordReqBody;

  ForgetPassParms({required this.forgetPasswordReqBody});
}
