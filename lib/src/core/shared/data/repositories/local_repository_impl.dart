import 'package:dartz/dartz.dart';
import 'package:test_multiplier_app/src/core/core.dart';

class LocalRepositoryImpl implements LocalRepository {
  final LocalDatasource _remoteDatasource;

  LocalRepositoryImpl({required LocalDatasource remoteDatasource})
    : _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, void>> saveConversation({
    required ConversationEntity conversation,
  }) async {
    try {
      await _remoteDatasource.saveConversation(
        ConversationMapper.toModel(conversation),
      );
      return const Right(null);
    } on ServerException catch (err) {
      return Left(ServerFailure(err.message));
    } catch (err) {
      return Left(UnknownFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ConversationEntity>>> getConversations() async {
    try {
      final result = await _remoteDatasource.getConversations();
      return Right(result.map((c) => ConversationMapper.toEntity(c)).toList());
    } on ServerException catch (err) {
      return Left(ServerFailure(err.message));
    } catch (err) {
      return Left(UnknownFailure(message: err.toString()));
    }
  }
}
