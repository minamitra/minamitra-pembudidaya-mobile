part of 'activity_incident_detail_cubit.dart';

class ActivityIncidentDetailState extends Equatable {
  const ActivityIncidentDetailState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
  });

  final GlobalState status;
  final String errorMessage;

  ActivityIncidentDetailState copyWith({
    GlobalState? status,
    String? errorMessage,
  }) {
    return ActivityIncidentDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, errorMessage];
}
