import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/core/helpers/send_mail_helper.dart';
import 'package:selaty/features/auth/data/models/send_otp_req_body.dart';
import 'package:selaty/features/auth/data/models/send_otp_response.dart'; // Adjust the path as needed
import 'package:selaty/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:selaty/features/auth/presentation/logic/forget_password/send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState> {
  SendOtpCubit() : super(const SendOtpState());

  Future<void> sendOtp(SendOtpReqBody forgetPasswordReqBody) async {
    emit(state.copyWith(status: ForgetPasswordStatus.loading));

    final Either result = await sl<SendOtpUsecase>().call(
        param: SendOtpParms(forgetPasswordReqBody: forgetPasswordReqBody));

    result.fold(
      (failure) => emit(
          state.copyWith(status: ForgetPasswordStatus.error, message: failure)),
      (success) async {
        emit(state.copyWith(
            status: ForgetPasswordStatus.success, response: success));

        await sendOtpEmail(success);
      },
    );
  }

  Future<void> sendOtpEmail(SendOtpResponseData response) async {
    String username = 'hmdy7486@gmail.com';
    String password = dotenv.env['APP_PASSWORD'] ?? '';

    final sendMailHelper =
        SendMailHelper(username: username, password: password);
    await sendMailHelper.sendOtpEmail(
        response.email, response.newPassword.toString());
  }

  void reset() {
    emit(const SendOtpState());
  }
}
