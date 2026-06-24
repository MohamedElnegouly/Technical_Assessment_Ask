import 'package:hive/hive.dart';
part 'auth_model.g.dart';

@HiveType(typeId: 0)
class AuthModel {
   @HiveField(0)
  final String message;
   @HiveField(1)
  final String? token;
   @HiveField(2)
  final UserModel? user;

  AuthModel({
    required this.message,
    this.token,
    this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      message: json['message'] ?? json['status'] ?? '', // fallback في حالة "fail"
      token: json['token'],
      user: json['user'] != null
          ? UserModel.fromJson(json['user'])
          : null,
    );
  }
}
 @HiveType(typeId: 1)
class UserModel {
   @HiveField(0)
  final String id;
   @HiveField(1)
  final String name;
   @HiveField(2)
  final String email;
   @HiveField(3)
  final String phone;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}
