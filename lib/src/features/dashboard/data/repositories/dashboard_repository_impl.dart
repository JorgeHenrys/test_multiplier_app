import 'package:dartz/dartz.dart';
import 'package:test_multiplier_app/src/core/core.dart';
import 'package:test_multiplier_app/src/features/features.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardDatasource _remoteDatasource;

  DashboardRepositoryImpl({required DashboardDatasource remoteDatasource})
    : _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, UserEntity>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDatasource.loginWithEmail(
        email: email,
        password: password,
      );
      return Right(UserMapper.toEntity(result));
    } on ServerException catch (err) {
      return Left(ServerFailure(err.message));
    } catch (err) {
      return Left(UnknownFailure(message: err.toString()));
    }
  }
}
