import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/usecase/usecase.dart';
import 'package:selaty/features/auth/data/models/update_profile_request_model.dart';
import 'package:selaty/features/auth/data/models/update_profile_response_model.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';

class UpdateProfileUsecase extends UseCase<
    Either<String, UpdateProfileResponseData>, UpdateProfileUsecaseParams> {
  @override
  Future<Either<String, UpdateProfileResponseData>> call(
      {UpdateProfileUsecaseParams? param}) {
    return sl<HomeRepo>().updateProfile(
        request: param!.request, profilePhoto: param.profilePhoto);
  }
}

class UpdateProfileUsecaseParams {
  final UpdateProfileRequest request;
  final File profilePhoto;

  UpdateProfileUsecaseParams(
      {required this.request, required this.profilePhoto});
}
