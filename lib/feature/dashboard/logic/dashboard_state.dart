part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  const DashboardState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
  });

  final GlobalState status;
  final String errorMessage;

  DashboardState copyWith({
    GlobalState? status,
    String? errorMessage,
  }) {
    return DashboardState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
      ];
}
