import 'package:dartz/dartz.dart';
import 'package:test_multiplier_app/src/core/core.dart';
import 'package:test_multiplier_app/src/features/auth/data/data.dart';
import 'package:test_multiplier_app/src/features/auth/domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _remoteDatasource;

  AuthRepositoryImpl({required AuthDatasource remoteDatasource})
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

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle() async {
    try {
      final result = await _remoteDatasource.loginWithGoogle();
      return Right(UserMapper.toEntity(result));
    } on ServerException catch (err) {
      return Left(ServerFailure(err.message));
    } catch (err) {
      return Left(UnknownFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await _remoteDatasource.logout();
      return Right(unit);
    } on ServerException catch (err) {
      return Left(ServerFailure(err.message));
    } catch (err) {
      return Left(UnknownFailure(message: err.toString()));
    }
  }

  @override
  Either<Failure, UserEntity?> getCurrentUser() {
    try {
      final user = _remoteDatasource.getCurrentUser();

      if (user != null) {
        return Right(UserMapper.toEntity(user));
      }
      return Right(null);
    } on ServerException catch (err) {
      return Left(ServerFailure(err.message));
    } catch (err) {
      return Left(UnknownFailure(message: err.toString()));
    }
  }
}
