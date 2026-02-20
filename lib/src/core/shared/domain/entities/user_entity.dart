import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String email;
  final String id;
  final String name;

  const UserEntity({required this.email, required this.id, required this.name});

  UserEntity copyWith({String? email, String? id, String? name}) {
    return UserEntity(
      email: email ?? this.email,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [email, id, name];
}
