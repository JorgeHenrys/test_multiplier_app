import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_multiplier_app/src/core/core.dart';
import 'package:test_multiplier_app/src/features/features.dart';

class ChatContent extends StatelessWidget {
  final TextEditingController messageController;
  final ScrollController scrollController;

  const ChatContent({
    super.key,
    required this.messageController,
    required this.scrollController,
  });

  void _scrollToBottom() {
    if (!scrollController.hasClients) return;

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state.status != ChatStatus.success) {
              return SizedBox.shrink();
            }

            final isTyping = state.typingStatus == TypingMessageStatus.typing;

            return Column(
              children: [
                /// LISTA DE MENSAGENS
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    itemCount:
                        state.conversation!.messages.length +
                        (isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      final messages = state.conversation?.messages ?? [];

                      if (isTyping && index == messages.length) {
                        return const ChatTypingIndicator();
                      }

                      final message = messages[index];
                      final isUser = message.sender == SenderEnum.user;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: isUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.content,
                              textAlign: isUser
                                  ? TextAlign.right
                                  : TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isUser
                                    ? MultiplierColors.neutral_500
                                    : MultiplierColors.neutral_700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              (isUser ? 'EU • ' : 'LARA • ') +
                                  context.read<ChatCubit>().timeAgo(
                                    message.createdAt,
                                  ),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// INPUT FIXO NA PARTE DE BAIXO
                Container(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 24,
                  ),
                  child: MultiplierBaseInput(
                    label: '',
                    controller: messageController,
                    validator: (String? value) =>
                        emailValidator(value, 'insira um email válido'),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        if (messageController.text.isNotEmpty) {
                          String message = messageController.text;
                          messageController.clear();
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _scrollToBottom();
                          });

                          final sendMessageResult = await context
                              .read<ChatCubit>()
                              .sendMessage(message);

                          if (sendMessageResult) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _scrollToBottom();
                            });
                          }
                        }
                      },
                      icon: Icon(Icons.send),
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
