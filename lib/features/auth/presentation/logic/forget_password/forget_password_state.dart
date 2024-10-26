import 'package:equatable/equatable.dart';
import 'package:selaty/core/enums/status.dart';
import 'package:selaty/features/auth/data/models/forget_pass_response.dart';

class ForgetPasswordState extends Equatable {
  final ForgetPasswordStatus status;
  final String email;
  final ForgetPasswordResponseData? response; // Now holds the entire response object
  final String? message;

  const ForgetPasswordState({
    this.status = ForgetPasswordStatus.initial,
    this.email = '',
    this.response,
    this.message,
  });

  ForgetPasswordState copyWith({
    ForgetPasswordStatus? status,
    String? email,
    ForgetPasswordResponseData? response,
    String? message,
  }) {
    return ForgetPasswordState(
      status: status ?? this.status,
      email: email ?? this.email,
      response: response ?? this.response,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, email, response, message];
}
