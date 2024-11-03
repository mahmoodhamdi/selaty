import 'package:equatable/equatable.dart';

class GetProfileResponse extends Equatable {
  final bool status;
  final String? message;
  final ProfileData? data;

  const GetProfileResponse({
    required this.status,
    this.message,
    this.data,
  });

  // Factory method to parse JSON response
  factory GetProfileResponse.fromJson(Map<String, dynamic> json) {
    return GetProfileResponse(
      status: json['status'] ?? false,
      message: json['message'] as String?,
      data: json['data'] != null ? ProfileData.fromJson(json['data']) : null,
    );
  }

  @override
  List<Object?> get props => [status, message, data];
}

class ProfileData extends Equatable {
  final String name;
  final String mobile;
  final String email;
  final String profilePhotoPath;
  final String? location;

  const ProfileData({
    required this.name,
    required this.mobile,
    required this.email,
    required this.profilePhotoPath,
    this.location,
  });

  // Factory method to parse JSON data
  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      name: json['name'],
      mobile: json['mobile'],
      email: json['email'],
      profilePhotoPath: json['profile_photo_path'] ?? '',
    );
  }
  //to json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mobile': mobile,
      'email': email,
      'profile_photo_path': profilePhotoPath,
      'location': location,
    };
  }

  ProfileData copyWith({
    String? location,
  }) {
    return ProfileData(
      mobile: mobile,
      name: name,
      email: email,
      profilePhotoPath: profilePhotoPath,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props => [name, mobile, email, profilePhotoPath, location];
}
