import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends Equatable {
  final String email;
  final String id;
  final String name;

  const UserModel({required this.email, required this.id, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      id: json['id'],
      name: json['name'] ?? '',
    );
  }

  factory UserModel.fromUser(User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'id': id, 'name': name};
  }

  @override
  List<Object?> get props => [email, id, name];
}
