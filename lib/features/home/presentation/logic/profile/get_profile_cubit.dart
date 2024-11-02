import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/core/helpers/location_helper.dart';
import 'package:selaty/features/home/domain/usecases/get_profile_usecase.dart';

import 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  GetProfileCubit() : super(const GetProfileState());

  Future<void> fetchProfile(BuildContext context) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    // Fetch profile data
    final result = await sl<GetProfileUsecase>().call();

    await result.fold(
      (error) {
        emit(state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: error,
        ));
      },
      (profileData) async {
        // Fetch location using LocationHelper
        final location =
            await LocationHelper.getAddressFromCurrentLocation(context);

        // Add location to profile data if it was successfully retrieved
        final updatedProfileData = profileData.copyWith(location: location);

        emit(state.copyWith(
          status: ProfileStatus.success,
          profileData: updatedProfileData,
        ));
      },
    );
  }
}
