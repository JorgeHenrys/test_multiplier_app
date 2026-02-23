import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_multiplier_app/src/features/features.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository _authRepository;
  DashboardCubit({required DashboardRepository authRepository})
    : _authRepository = authRepository,
      super(DashboardState.initial());

  Future<void> signInWithEmail(String email, String password) async {
    emit(state.copyWith(status: DashboardStatus.loading));
    final result = await _authRepository.loginWithEmail(
      email: email,
      password: password,
    );

    result.fold(
      (l) {
        debugPrint(l.message);
        emit(state.copyWith(status: DashboardStatus.error));
      },
      (user) async {
        debugPrint(user.name);

        emit(state.copyWith(status: DashboardStatus.success));
      },
    );
  }

  String timeAgo(DateTime date) {
    final now = DateTime.now();
    if (date.isAfter(now)) return "agora";

    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      final seconds = difference.inSeconds;
      return seconds <= 1 ? "há 1 segundo" : "há $seconds segundos";
    }

    if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return minutes == 1 ? "há 1 minuto" : "há $minutes minutos";
    }

    if (difference.inHours < 24) {
      final hours = difference.inHours;
      return hours == 1 ? "há 1 hora" : "há $hours horas";
    }

    if (difference.inDays < 7) {
      final days = difference.inDays;
      return days == 1 ? "há 1 dia" : "há $days dias";
    }

    if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? "há 1 semana" : "há $weeks semanas";
    }

    if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? "há 1 mês" : "há $months meses";
    }

    final years = (difference.inDays / 365).floor();
    return years == 1 ? "há 1 ano" : "há $years anos";
  }
}
