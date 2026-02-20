import 'package:dartz/dartz.dart';
import 'package:test_multiplier_app/src/core/core.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> loginWithEmail({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> loginWithGoogle();
  Future<Either<Failure, Unit>> logout();
  Either<Failure, UserEntity?> getCurrentUser();
}
