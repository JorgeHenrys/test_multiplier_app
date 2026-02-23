import 'package:test_multiplier_app/src/core/core.dart';

abstract class ChatDatasource {
  Future<MessageModel> sendMessageStream({
    required List<MessageEntity> messages,
  });
}
