import 'package:dartz/dartz.dart';
import 'package:test_multiplier_app/src/core/core.dart';

abstract class LocalRepository {
  Future<Either<Failure, void>> saveConversation({
    required ConversationEntity conversation,
  });

  Future<Either<Failure, List<ConversationEntity>>> getConversations();
}
