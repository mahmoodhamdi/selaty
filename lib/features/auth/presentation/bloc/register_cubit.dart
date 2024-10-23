import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/register_status.dart';
import 'package:selaty/features/auth/domain/usecases/register_usecase.dart';
import 'package:selaty/features/auth/presentation/bloc/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  Future<void> register(RegisterParams params) async {
    emit(state.copyWith(status: RegisterStatus.loading));

    final result = await sl<RegisterUseCase>().call(param: params);

    result.fold(
      (error) {
        emit(state.copyWith(
          status: RegisterStatus.failure,
          message: error.toString(), // Handle error appropriately
        ));
      },
      (success) {
        emit(state.copyWith(
          status: RegisterStatus.success,
          message: "تم إنشاء حسابك بنجاح", // Adjust based on response
        ));
      },
    );
  }
}
