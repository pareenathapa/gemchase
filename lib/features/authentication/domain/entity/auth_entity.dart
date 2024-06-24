import 'package:equatable/equatable.dart';


class AuthEntity extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final String? password;
  final String? confirmpassword;

  const AuthEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.password, 
    this.confirmpassword,
  });

  @override
  List<Object?> get props =>
      [id, firstName, lastName, phone, email, password, confirmpassword];
}