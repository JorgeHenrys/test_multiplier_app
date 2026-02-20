import 'package:test_multiplier_app/src/core/core.dart';

abstract class AuthDatasource {
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  });
  Future<UserModel> loginWithGoogle();
  Future<void> logout();
  UserModel? getCurrentUser();
}
