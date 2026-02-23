import 'package:dartz/dartz.dart';
import 'package:test_multiplier_app/src/core/core.dart';
import 'package:test_multiplier_app/src/features/features.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDatasource _remoteDatasource;

  ChatRepositoryImpl({required ChatDatasource remoteDatasource})
    : _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, MessageEntity>> sendMessageStream({
    required List<MessageEntity> messages,
  }) async {
    try {
      final result = await _remoteDatasource.sendMessageStream(
        messages: messages,
      );
      return Right(MessageMapper.toEntity(result));
    } on ServerException catch (err) {
      return Left(ServerFailure(err.message));
    } catch (err) {
      return Left(UnknownFailure(message: err.toString()));
    }
  }
}
