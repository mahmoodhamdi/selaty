import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/auth/data/models/forget_password_req_body.dart';
import 'package:selaty/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:selaty/features/auth/presentation/logic/forget_password/forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(const ForgetPasswordState());

  Future<void> resetPassword(
      ForgetPasswordReqBody forgetPasswordReqBody) async {
    emit(state.copyWith(status: ForgetPasswordStatus.loading));

    final Either result = await sl<ForgetPasswordUsecase>().call(
        param: ForgetPassParms(forgetPasswordReqBody: forgetPasswordReqBody));

    result.fold(
      (failure) => emit(
          state.copyWith(status: ForgetPasswordStatus.error, message: failure)),
      (success) => emit(state.copyWith(
          status: ForgetPasswordStatus.success, response: success)),
    );
  }

  void reset() {
    emit(const ForgetPasswordState());
  }
}
