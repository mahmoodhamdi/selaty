import 'package:equatable/equatable.dart';

class RegisterReqBody extends Equatable {
  final String name;
  final String email;
  final String password;
  final String address;

  const RegisterReqBody({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'address': address,
      };

  @override
  List<Object?> get props => [name, email, password, address];
}
