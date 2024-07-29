
    import 'dart:convert';
    import 'package:flutter/foundation.dart';
    import 'user_data_entity.dart';

    class AuthDTO {
  final bool? success;
  final String? message;
  final String? token;
  final UserDataEntity? userData;
AuthDTO({
    this.success,
    this.message,
    this.token,
    this.userData,
  });
  AuthDTO copyWith({
    ValueGetter<bool?>? success,
    ValueGetter<String?>? message,
    ValueGetter<String?>? token,
    ValueGetter<UserDataEntity?>? userData,
  }) {
    return AuthDTO(
      success: success != null ? success(): this.success,
      message: message != null ? message(): this.message,
      token: token != null ? token(): this.token,
      userData: userData != null ? userData(): this.userData,
    );
  }
  @override
  String toString() {
    return 'AuthDTO {"success": $success, "message": $message, "token": $token, "userData": $userData, }';
  }
  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'message': message,
      'token': token,
      'user_data': userData?.toMap(),
    };
  }
  factory AuthDTO.fromMap(Map<String, dynamic> map) {
    return AuthDTO(
      success: map['success'],
      message: map['message'],
      token: map['token'],
      userData:map['user_data'] !=null ? UserDataEntity.fromMap(map['user_data']): null,
    );
  }
  

String toJson() => json.encode(toMap());

  factory AuthDTO.fromJson(String source) =>
    AuthDTO.fromMap(json.decode(source) as Map<String, dynamic>);


  @override
  bool operator ==(covariant AuthDTO other) {
    if (identical(this, other)) return true;
    return   success == other.success &&
   message == other.message &&
   token == other.token &&
   userData == other.userData;
  }
  @override
  int get hashCode {
    return success.hashCode ^
message.hashCode ^
token.hashCode ^
userData.hashCode;
  }
}

