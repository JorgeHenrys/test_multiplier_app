import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_multiplier_app/src/core/core.dart';
import 'package:test_multiplier_app/src/features/features.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state.status != DashboardStatus.success) {
          return Center(
            child: CircularProgressIndicator(color: MultiplierColors.primary),
          );
        }

        if (state.conversations.isEmpty) {
          return Center(
            child: Text(
              'Nenhuma conversa salva',
              style: TextStyle(
                color: MultiplierColors.neutral_500,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }

        return SingleChildScrollView(
          child: Center(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 26,
                      left: 24,
                      right: 24,
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: state.conversations
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
        );
      },
    );
  }
}
