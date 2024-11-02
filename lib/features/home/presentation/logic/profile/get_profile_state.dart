import 'package:equatable/equatable.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/home/data/models/get_profile_response.dart';

class GetProfileState extends Equatable {
  final ProfileStatus status;
  final String? errorMessage;
  final ProfileData? profileData;

  const GetProfileState({
    this.status = ProfileStatus.initial,
    this.errorMessage,
    this.profileData,
  });

  GetProfileState copyWith({
    ProfileStatus? status,
    String? errorMessage,
    ProfileData? profileData,
  }) {
    return GetProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      profileData: profileData,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, profileData];
}
