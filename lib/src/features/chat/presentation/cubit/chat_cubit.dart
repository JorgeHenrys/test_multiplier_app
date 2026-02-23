import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_multiplier_app/src/core/core.dart';
import 'package:test_multiplier_app/src/features/features.dart';
import 'package:uuid/uuid.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _chatRepository;
  ChatCubit({required ChatRepository chatRepository})
    : _chatRepository = chatRepository,
      super(ChatState.initial());

  FutureOr<bool> sendMessage(String message) async {
    bool isMessage = false;

    final messagesCopy = List<MessageEntity>.from(state.conversation!.messages)
      ..add(
        MessageEntity(
          id: Uuid().v1(),
          content: message,
          sender: SenderEnum.user,
          createdAt: DateTime.now(),
        ),
      );

    emit(
      state.copyWith(
        typingStatus: TypingMessageStatus.typing,
        conversation: state.conversation!.copyWith(messages: messagesCopy),
      ),
    );

    final result = await _chatRepository.sendMessageStream(
      messages: messagesCopy,
    );

    result.fold(
      (failure) {
        debugPrint(failure.message);
        emit(state.copyWith(typingStatus: TypingMessageStatus.error));
      },
      (assistantMessage) async {
        final updatedMessages = List<MessageEntity>.from(messagesCopy)
          ..add(assistantMessage);

        //await repositoryLocal.saveConversation(conversation);

        emit(
          state.copyWith(
            typingStatus: TypingMessageStatus.idle,
            conversation: state.conversation!.copyWith(
              title: state.conversation!.messages.length == 1
                  ? generateTitle(message)
                  : state.conversation!.title,
              messages: updatedMessages,
              updatedAt: DateTime.now(),
            ),
          ),
        );
        isMessage = true;
      },
    );

    return isMessage;
  }

  Future<void> initialize(ConversationEntity? conversation) async {
    if (conversation == null) {
      emit(
        state.copyWith(
          conversation: ConversationEntity(
            id: Uuid().v1(),
            title: '',
            messages: [],
            updatedAt: DateTime.now(),
          ),
          status: ChatStatus.success,
        ),
      );
    } else {
      emit(
        state.copyWith(conversation: conversation, status: ChatStatus.success),
      );
    }
  }

  String timeAgo(DateTime date) {
    final now = DateTime.now();
    if (date.isAfter(now)) return "agora";

    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      final seconds = difference.inSeconds;
      return seconds <= 1 ? "há 1 segundo" : "há $seconds segundos";
    }

    if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return minutes == 1 ? "há 1 minuto" : "há $minutes minutos";
    }

    if (difference.inHours < 24) {
      final hours = difference.inHours;
      return hours == 1 ? "há 1 hora" : "há $hours horas";
    }

    if (difference.inDays < 7) {
      final days = difference.inDays;
      return days == 1 ? "há 1 dia" : "há $days dias";
    }

    if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? "há 1 semana" : "há $weeks semanas";
    }

    if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? "há 1 mês" : "há $months meses";
    }

    final years = (difference.inDays / 365).floor();
    return years == 1 ? "há 1 ano" : "há $years anos";
  }

  String generateTitle(String text) {
    if (text.length <= 30) return text;
    return "${text.substring(0, 30)}...";
  }
}
