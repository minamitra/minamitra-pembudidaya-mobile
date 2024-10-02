part of 'activity_incident_add_cubit.dart';

class ActivityIncidentAddState extends Equatable {
  const ActivityIncidentAddState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
  });

  final GlobalState status;
  final String errorMessage;

  ActivityIncidentAddState copyWith({
    GlobalState? status,
    String? errorMessage,
  }) {
    return ActivityIncidentAddState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
      ];
}
