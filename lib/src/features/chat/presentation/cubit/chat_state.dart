part of 'chat_cubit.dart';

enum ChatStatus { success, loading, idle, error }

enum TypingMessageStatus { typing, error, idle }

class ChatState extends Equatable {
  final ChatStatus status;
  final ConversationEntity? conversation;
  final TypingMessageStatus typingStatus;

  const ChatState({
    required this.status,
    this.conversation,
    required this.typingStatus,
  });

  factory ChatState.initial() => const ChatState(
    status: ChatStatus.idle,
    typingStatus: TypingMessageStatus.idle,
  );

  ChatState copyWith({
    ChatStatus? status,
    ConversationEntity? conversation,
    TypingMessageStatus? typingStatus,
  }) {
    return ChatState(
      status: status ?? this.status,
      conversation: conversation ?? this.conversation,
      typingStatus: typingStatus ?? this.typingStatus,
    );
  }

  @override
  List<Object?> get props => [status, conversation, typingStatus];
}
