import 'package:equatable/equatable.dart';
import 'package:test_multiplier_app/src/core/core.dart';

class ConversationModel extends Equatable {
  final String id;
  final String title;
  final List<MessageModel> messages;
  final String updatedAt;

  const ConversationModel({
    required this.id,
    required this.title,
    required this.messages,
    required this.updatedAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] ?? '',
      title: json['title'],
      messages: json['messages'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'messages': messages.map((m) => m.toJson()).toList(),
      'updatedAt': updatedAt,
    };
  }

  @override
  List<Object?> get props => [id, title, messages, updatedAt];
}
