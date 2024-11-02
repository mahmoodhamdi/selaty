import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/domain/usecases/update_profile_usecase.dart';
import 'package:selaty/features/home/presentation/logic/update_profile/update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileState.initial());

  Future<void> updateProfile(UpdateProfileUsecaseParams params) async {
    emit(state.copyWith(status: UpdateProfileStatus.loading));

    final result = await sl<UpdateProfileUsecase>().call(param: params);

    result.fold(
      (error) {
        emit(state.copyWith(
          status: UpdateProfileStatus.failure,
          message: error,
        ));
      },
      (responseData) {
        emit(state.copyWith(
          status: UpdateProfileStatus.success,
          responseData: responseData,
        ));
      },
    );
  }
}
