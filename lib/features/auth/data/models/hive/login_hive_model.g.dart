// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginHiveModelAdapter extends TypeAdapter<LoginHiveModel> {
  @override
  final int typeId = 1;

  @override
  LoginHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginHiveModel(
      token: fields[0] as String?,
      user: fields[1] as UserHiveModel?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
