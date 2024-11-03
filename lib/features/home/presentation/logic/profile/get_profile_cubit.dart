  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:selaty/core/depandancy_injection/service_locator.dart';
  import 'package:selaty/core/enums/status.dart';
  import 'package:selaty/features/home/domain/usecases/get_profile_usecase.dart';

  import 'get_profile_state.dart';

  class GetProfileCubit extends Cubit<GetProfileState> {
    GetProfileCubit() : super(const GetProfileState());

    Future<void> fetchProfile() async {
      emit(state.copyWith(status: ProfileStatus.loading));

      final result = await sl<GetProfileUsecase>().call();

      result.fold(
        (error) => emit(
            state.copyWith(status: ProfileStatus.failure, errorMessage: error)),
        (profileData) => emit(state.copyWith(
            status: ProfileStatus.success, profileData: profileData)),
      );
    }
  }
