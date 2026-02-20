import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_multiplier_app/src/features/auth/domain/domain.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthState.initial());

  Future<void> signInAuth(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _authRepository.loginWithEmail(
      email: email,
      password: password,
    );

    result.fold(
      (l) {
        debugPrint(l.message);
        emit(state.copyWith(status: AuthStatus.error));
      },
      (user) async {
        //debugPrint(user.accessToken);
        // await prefs.setString('accessToken', user.accessToken);
        // await prefs.setString('refreshToken', user.refreshToken);

        emit(state.copyWith(status: AuthStatus.success));
      },
    );
  }
}
