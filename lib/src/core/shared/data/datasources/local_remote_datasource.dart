import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_multiplier_app/src/core/core.dart';

class LocalRemoteDatasource implements LocalDatasource {
  static const _key = "chat_conversations";

  @override
  Future<void> saveConversation(ConversationModel conversation) async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_key) ?? [];

    final conversations = stored.map((str) => jsonDecode(str)).toList();

    final index = conversations.indexWhere((c) => c["id"] == conversation.id);

    final updatedConversation = jsonEncode(conversation.toJson());

    if (index >= 0) {
      stored[index] = updatedConversation;
    } else {
      stored.add(updatedConversation);
    }

    stored.sort((a, b) {
      final aDate = DateTime.parse(jsonDecode(a)["updatedAt"]);
      final bDate = DateTime.parse(jsonDecode(b)["updatedAt"]);
      return bDate.compareTo(aDate);
    });

    await prefs.setStringList(_key, stored);
  }

  @override
  Future<List<ConversationModel>> getConversations() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_key) ?? [];
    return stored.map((str) {
      final doc = jsonDecode(str);
      return ConversationModel(
        id: doc["id"],
        title: doc["title"],
        messages: (doc["messages"] as List<dynamic>)
            .map((m) => MessageModel.fromJson(m))
            .toList(),
        updatedAt: doc["updatedAt"],
      );
    }).toList();
  }
}
