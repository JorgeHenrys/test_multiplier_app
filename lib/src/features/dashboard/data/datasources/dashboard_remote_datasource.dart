import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_multiplier_app/src/core/core.dart';
import 'package:test_multiplier_app/src/features/features.dart';

class DashboardRemoteDatasource implements DashboardDatasource {
  final FirebaseAuth _client;

  DashboardRemoteDatasource({required FirebaseAuth client}) : _client = client;

  @override
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        return UserModel.fromUser(response.user!);
      } else {
        throw ServerException(message: response.toString());
      }
    } on DioException catch (err) {
      throw ServerException(
        message: err.message ?? err.toString(),
        statusCode: err.response?.statusCode ?? 500,
      );
    }
  }
}
