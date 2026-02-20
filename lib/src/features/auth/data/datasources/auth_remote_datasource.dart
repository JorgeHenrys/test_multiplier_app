import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_multiplier_app/src/core/core.dart';
import 'package:test_multiplier_app/src/features/auth/data/data.dart';

class AuthRemoteDatasource implements AuthDatasource {
  final FirebaseAuth _client;

  AuthRemoteDatasource({required FirebaseAuth client}) : _client = client;

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

  @override
  Future<UserModel> loginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw ServerException(message: "Google login cancelled");
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _client.signInWithCredential(credential);

      final user = userCredential.user;

      if (user == null) {
        throw ServerException(message: "Google auth failed");
      }

      return UserModel.fromUser(user);
    } on DioException catch (err) {
      throw ServerException(
        message: err.message ?? err.toString(),
        statusCode: err.response?.statusCode ?? 500,
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _client.signOut();
      await GoogleSignIn().signOut();
    } on DioException catch (err) {
      throw ServerException(
        message: err.message ?? err.toString(),
        statusCode: err.response?.statusCode ?? 500,
      );
    }
  }

  @override
  UserModel? getCurrentUser() {
    try {
      final user = _client.currentUser;
      if (user == null) return null;

      return UserModel.fromUser(user);
    } on DioException catch (err) {
      throw ServerException(
        message: err.message ?? err.toString(),
        statusCode: err.response?.statusCode ?? 500,
      );
    }
  }
}
