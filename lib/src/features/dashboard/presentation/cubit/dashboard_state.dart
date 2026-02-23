part of 'dashboard_cubit.dart';

enum DashboardStatus { success, loading, idle, error }

class DashboardState extends Equatable {
  final DashboardStatus status;

  const DashboardState({required this.status});

  factory DashboardState.initial() =>
      const DashboardState(status: DashboardStatus.idle);

  DashboardState copyWith({DashboardStatus? status}) {
    return DashboardState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
