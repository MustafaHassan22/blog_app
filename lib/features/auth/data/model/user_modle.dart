import 'package:blogapp/features/auth/domain/entitie/user.dart';

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
}
