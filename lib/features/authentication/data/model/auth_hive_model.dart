
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/auth_entity.dart';


part 'auth_hive_model.g.dart';
//dart run build_runner build -d

final authHiveModelProvider = Provider(
  (ref) => AuthHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String? firstName;

    @HiveField(2)
  final String? lastName;

  @HiveField(3)
  final String? phone;

  @HiveField(4)
  final String? email;

  @HiveField(5)
  final String? password;

  @HiveField(6)
  final String? confirmpassword;


  // Constructor
  AuthHiveModel({
    String? userId,
    this.firstName,
    this.lastName,
    this.phone,
    required this.email,
    required this.password,
    required this.confirmpassword,
  }) : userId = userId ?? const Uuid().v4();

  // empty constructor
  AuthHiveModel.empty()
      : this(
          userId: '',
          firstName: '',
          lastName: '',
          phone: '',
          email: '',
          password: '',
          confirmpassword: '',
        );

  // Convert Hive Object to Entity
  AuthEntity toEntity() => AuthEntity(
        id: userId,
        firstName: firstName,
        lastName:lastName,
        phone: phone,
        email: email,
        password: password,
        confirmpassword: confirmpassword,
      );

  // Convert Entity to Hive Object
  AuthHiveModel toHiveModel(AuthEntity entity) => AuthHiveModel(
        userId: const Uuid().v4(),
        firstName: entity.firstName,
        lastName: entity.lastName,
        phone: entity.phone,
        email: entity.email,
        password: entity.password,
        confirmpassword: entity.confirmpassword,
      );

  // Convert Entity List to Hive List
  List<AuthHiveModel> toHiveModelList(List<AuthEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'userId: $userId, firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, password: $password, confirmpassword: $confirmpassword';
  }
}


