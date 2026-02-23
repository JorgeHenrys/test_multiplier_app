import 'package:dartz/dartz.dart';
import 'package:test_multiplier_app/src/core/core.dart';

abstract class DashboardRepository {
  Future<Either<Failure, UserEntity>> loginWithEmail({
    required String email,
    required String password,
  });
}
