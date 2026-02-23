import 'package:test_multiplier_app/src/core/core.dart';

abstract class LocalDatasource {
  Future<void> saveConversation(ConversationModel conversation);
  Future<List<ConversationModel>> getConversations();
}
