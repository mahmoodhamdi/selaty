import 'package:equatable/equatable.dart';
import 'package:selaty/core/enums/register_status.dart';

class RegisterState extends Equatable {
  final RegisterStatus status;
  final String message; // Optional: for success/failure messages

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.message = '',
  });

  RegisterState copyWith({
    RegisterStatus? status,
    String? message,
  }) {
    return RegisterState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, message];
}
