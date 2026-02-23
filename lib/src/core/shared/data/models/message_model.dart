import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final String id;
  final String content;
  final String sender;
  final String createdAt;

  const MessageModel({
    required this.id,
    required this.content,
    required this.sender,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      content: json['content'],
      sender: json['sender'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'sender': sender,
      'createdAt': createdAt,
    };
  }

  @override
  List<Object?> get props => [id, content, sender, createdAt];
}
