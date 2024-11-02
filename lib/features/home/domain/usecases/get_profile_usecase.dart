import 'package:dartz/dartz.dart';
import 'package:selaty/core/depandancy_injection/service_locator.dart';
import 'package:selaty/core/usecase/usecase.dart';
import 'package:selaty/features/home/data/models/get_profile_response.dart';
import 'package:selaty/features/home/domain/repository/home_repo.dart';

class GetProfileUsecase
    implements UseCase<Either<String, ProfileData>, NoParams> {
  @override
  Future<Either<String, ProfileData>> call({NoParams? param}) async {
    final result = await sl<HomeRepo>().getProfile();
    return result.fold(
      (error) => Left(error),
      (profile) => Right(profile),
    );
  }
}
