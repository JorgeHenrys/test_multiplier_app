import 'package:flutter/material.dart';

class ChatTypingIndicator extends StatelessWidget {
  const ChatTypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "LARA está digitando...",
            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
