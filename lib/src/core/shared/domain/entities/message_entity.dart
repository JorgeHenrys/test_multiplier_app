import 'package:equatable/equatable.dart';
import 'package:test_multiplier_app/src/core/core.dart';

class MessageEntity extends Equatable {
  final String id;
  final String content;
  final SenderEnum sender;
  final DateTime createdAt;

  const MessageEntity({
    required this.id,
    required this.content,
    required this.sender,
    required this.createdAt,
  });

  MessageEntity copyWith({
    String? id,
    String? content,
    SenderEnum? sender,
    DateTime? createdAt,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      content: content ?? this.content,
      sender: sender ?? this.sender,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, content, sender, createdAt];
}
