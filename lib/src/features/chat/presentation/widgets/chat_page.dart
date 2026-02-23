import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_multiplier_app/src/core/core.dart';
import 'package:test_multiplier_app/src/features/features.dart';

class ChatPage extends StatefulWidget {
  final ConversationEntity? conversation;

  const ChatPage({super.key, this.conversation});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController messageController;
  late ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatCubit>(
      create: (context) => injector()..initialize(widget.conversation),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Lara • ${widget.conversation == null ? 'novo chat' : widget.conversation!.title}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: MultiplierColors.neutral_500,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          // actions: [
          //   IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.logout_outlined,
          //       color: MultiplierColors.neutral_500,
          //     ),
          //   ),
          // ],
        ),
        body: ChatContent(
          messageController: messageController,
          scrollController: scrollController,
        ),
      ),
    );
  }
}
