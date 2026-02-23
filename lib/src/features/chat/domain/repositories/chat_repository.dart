import 'package:dartz/dartz.dart';
import 'package:test_multiplier_app/src/core/core.dart';

abstract class ChatRepository {
  Future<Either<Failure, MessageEntity>> sendMessageStream({
    required List<MessageEntity> messages,
  });
}
