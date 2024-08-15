import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';


part 'app_settings_hive_model.g.dart';

@HiveType(
  typeId: HiveTableConstant.appSettingsTableId,
)
class AppSettingsHiveModel {
  @HiveField(0)
  final LoginHiveModel? user;

  @HiveField(1)
  final LoginHiveModel? fingerPrintUser;

  AppSettingsHiveModel({
    this.user,
    this.fingerPrintUser,
  });

  factory AppSettingsHiveModel.empty() {
    return AppSettingsHiveModel(
      user: null,
    );
  }

  AppSettingsHiveModel copyWith({
    ValueGetter<LoginHiveModel?>? user,
    ValueGetter<LoginHiveModel?>? fingerPrintUser,
  }) {
    return AppSettingsHiveModel(
      user: user != null ? user() : this.user,
      fingerPrintUser:
          fingerPrintUser != null ? fingerPrintUser() : this.fingerPrintUser,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user?.toMap(),
      'finger_print_user': fingerPrintUser?.toMap(),
    };
  }

  factory AppSettingsHiveModel.fromMap(Map<String, dynamic> map) {
    return AppSettingsHiveModel(
      user: map['user'] != null ? LoginHiveModel.fromMap(map['user']) : null,
      fingerPrintUser: map['finger_print_user'] != null
          ? LoginHiveModel.fromMap(map['finger_print_user'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppSettingsHiveModel.fromJson(String source) =>
      AppSettingsHiveModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'AppSettingsHiveModel(user: $user, fingerPrintUser: $fingerPrintUser)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppSettingsHiveModel &&
        other.user == user &&
        other.fingerPrintUser == fingerPrintUser;
  }

  @override
  int get hashCode => user.hashCode ^ fingerPrintUser.hashCode;
}
