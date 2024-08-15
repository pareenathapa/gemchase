import 'dart:convert';

import 'package:flutter/widgets.dart';

class Failure {
  final String error;
  final String? statusCode;

  Failure({
    required this.error,
    this.statusCode,
  });

  Failure copyWith({
    String? error,
    ValueGetter<String?>? statusCode,
  }) {
    return Failure(
      error: error ?? this.error,
      statusCode: statusCode != null ? statusCode() : this.statusCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'error': error,
      'status_code': statusCode,
    };
  }

  factory Failure.fromMap(Map<String, dynamic> map) {
    return Failure(
      error: map['error'] ?? '',
      statusCode: map['status_code'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Failure.fromJson(String source) =>
      Failure.fromMap(json.decode(source));

  @override
  String toString() => 'Failure(error: $error, statusCode: $statusCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure &&
        other.error == error &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode => error.hashCode ^ statusCode.hashCode;
}
