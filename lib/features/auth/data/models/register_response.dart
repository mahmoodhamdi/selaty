import 'package:equatable/equatable.dart';

class RegisterResponse extends Equatable {
  final bool status;
  final String errorMessage;
  final String errorMessageEn;
  final UserData data;

  const RegisterResponse({
    required this.status,
    required this.errorMessage,
    required this.errorMessageEn,
    required this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      status: json['status'],
      errorMessage: json['error_message'],
      errorMessageEn: json['error_message_en'],
      data: UserData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'error_message': errorMessage,
      'error_message_en': errorMessageEn,
      'data': data.toJson(),
    };
  }

  @override
  List<Object?> get props => [status, errorMessage, errorMessageEn, data];
}

class UserData extends Equatable {
  final String mobile;
  final String name;
  final String email;
  final String address;
  final String? profilePhotoPath;
  final String token;

  const UserData({
    required this.mobile,
    required this.name,
    required this.email,
    required this.address,
    this.profilePhotoPath,
    required this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      mobile: json['mobile'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      profilePhotoPath: json['profile_photo_path'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
      'name': name,
      'email': email,
      'address': address,
      'profile_photo_path': profilePhotoPath,
      'token': token,
    };
  }

  @override
  List<Object?> get props =>
      [mobile, name, email, address, profilePhotoPath, token];
}
