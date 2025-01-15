import 'package:blogapp/core/common/entitie/user.dart';

class UserModle extends User {
  UserModle({
    required super.id,
    required super.email,
    required super.name,
  });

  factory UserModle.fromJson(Map<String, dynamic> map) {
    return UserModle(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
    );
  }

  UserModle copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return UserModle(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
