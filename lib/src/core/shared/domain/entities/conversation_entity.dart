import 'package:equatable/equatable.dart';
import 'package:test_multiplier_app/src/core/core.dart';

class ConversationEntity extends Equatable {
  final String id;
  final String title;
  final List<MessageEntity> messages;
  final DateTime updatedAt;

  const ConversationEntity({
    required this.id,
    required this.title,
    required this.messages,
    required this.updatedAt,
  });

  ConversationEntity copyWith({
    String? id,
    String? title,
    List<MessageEntity>? messages,
    DateTime? updatedAt,
  }) {
    return ConversationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      messages: messages ?? this.messages,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, title, messages, updatedAt];
}
