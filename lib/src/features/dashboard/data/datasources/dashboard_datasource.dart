import 'package:test_multiplier_app/src/core/core.dart';

abstract class DashboardDatasource {
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  });
}
