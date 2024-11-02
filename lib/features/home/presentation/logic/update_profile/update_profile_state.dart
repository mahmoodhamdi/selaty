import 'package:equatable/equatable.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/auth/data/models/update_profile_response_model.dart';

class UpdateProfileState extends Equatable {
  final UpdateProfileStatus status;
  final String? message;
  final UpdateProfileResponseData? responseData;

  const UpdateProfileState({
    required this.status,
    this.message,
    this.responseData,
  });

  factory UpdateProfileState.initial() {
    return const UpdateProfileState(status: UpdateProfileStatus.initial);
  }

  UpdateProfileState copyWith({
    UpdateProfileStatus? status,
    String? message,
    UpdateProfileResponseData? responseData,
  }) {
    return UpdateProfileState(
      status: status ?? this.status,
      message: message ?? this.message,
      responseData: responseData ?? this.responseData,
    );
  }

  @override
  List<Object?> get props => [status, message, responseData];
}
