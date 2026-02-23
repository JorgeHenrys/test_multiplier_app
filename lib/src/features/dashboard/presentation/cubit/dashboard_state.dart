part of 'dashboard_cubit.dart';

enum DashboardStatus { success, loading, idle, error }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final List<ConversationEntity> conversations;

  const DashboardState({required this.status, required this.conversations});

  factory DashboardState.initial() =>
      const DashboardState(status: DashboardStatus.idle, conversations: []);

  DashboardState copyWith({
    DashboardStatus? status,
    List<ConversationEntity>? conversations,
  }) {
    return DashboardState(
      status: status ?? this.status,
      conversations: conversations ?? this.conversations,
    );
  }

  @override
  List<Object?> get props => [status, conversations];
}
