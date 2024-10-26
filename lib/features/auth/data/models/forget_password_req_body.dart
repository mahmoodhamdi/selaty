import 'package:equatable/equatable.dart';

class ForgetPasswordReqBody extends Equatable {
  final String email;

  const ForgetPasswordReqBody({required this.email});

  // Convert the Dart object to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  // Create a factory constructor to create an instance from JSON
  factory ForgetPasswordReqBody.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordReqBody(
      email: json['email'],
    );
  }

  @override
  List<Object> get props =>
      [email]; // Equatable: Define the properties for comparison
}
