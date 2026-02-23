import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_multiplier_app/src/core/core.dart';
import 'package:test_multiplier_app/src/features/features.dart';

class DashboardContent extends StatelessWidget {
  DashboardContent({super.key});

  final List<ConversationEntity> conversations = [
    ConversationEntity(
      id: '1',
      title: 'Como pesquisar..',
      messages: [
        MessageEntity(
          id: '1',
          content: 'Olá, tudo bem?',
          sender: SenderEnum.user,
          createdAt: DateTime.now(),
        ),
        MessageEntity(
          id: '2',
          content: 'tudo bem?',
          sender: SenderEnum.lara,
          createdAt: DateTime.now(),
        ),
      ],
      updatedAt: DateTime.now(),
    ),
    ConversationEntity(
      id: '2',
      title: 'Queria ver o caso',
      messages: [
        MessageEntity(
          id: '1',
          content: 'Olá, tudo bem?',
          sender: SenderEnum.user,
          createdAt: DateTime.now(),
        ),
      ],
      updatedAt: DateTime.now(),
    ),
    ConversationEntity(
      id: '3',
      title: 'Posso adicionar',
      messages: [
        MessageEntity(
          id: '1',
          content: 'Olá, tudo bem?',
          sender: SenderEnum.user,
          createdAt: DateTime.now(),
        ),
        MessageEntity(
          id: '2',
          content: 'tudo bem?',
          sender: SenderEnum.lara,
          createdAt: DateTime.now(),
        ),
      ],
      updatedAt: DateTime.now(),
    ),
  ];

  void showSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      elevation: 10,
      content: Row(
        children: [
          Icon(
            Icons.warning_amber_outlined,
            color: MultiplierColors.neutral_100,
          ),
          SizedBox(width: 20),
          Text(
            'Falha no login, tente novamente!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: MultiplierColors.neutral_100,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      backgroundColor: MultiplierColors.error,
      padding: EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardCubit, DashboardState>(
      listener: (context, state) {
        if (state.status == DashboardStatus.error) {
          showSnackBar(context);
        }
        if (state.status == DashboardStatus.success) {
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return Container();
              },
            ),
            (_) => false,
          );
        }
      },
      child: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 26, left: 24, right: 24),
                  child: Column(
                    children: [
                      Column(
                        children: [...conversations, ...conversations]
                            .map(
                              (chat) => InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChatPage(conversation: chat),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    chat.title,
                                    style: TextStyle(
                                      color: MultiplierColors.neutral_500,
                                      fontSize: 18,
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  subtitle: Text(
                                    'LARA: ${chat.messages.last.content}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: Text(
                                    context.read<DashboardCubit>().timeAgo(
                                      chat.updatedAt,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
