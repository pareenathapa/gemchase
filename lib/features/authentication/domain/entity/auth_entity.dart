import 'package:equatable/equatable.dart';


class AuthEntity extends Equatable {
  final String? id;
  final String? fullName;
  final String? image;
  final String? phone;
  final String? email;
  final String? password;

  const AuthEntity({
    this.id,
    this.fullName,
    this.image,
    this.phone,
    this.email,
    this.password, 
  });

  @override
  List<Object?> get props =>
      [id, fullName, image, phone, email, password];
}