part of 'incident_history_cubit.dart';

class IncidentHistoryState extends Equatable {
  const IncidentHistoryState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.incidents,
  });

  final GlobalState status;
  final String errorMessage;
  final List<IncidentResponseData>? incidents;

  IncidentHistoryState copyWith({
    GlobalState? status,
    String? errorMessage,
    List<IncidentResponseData>? incidents,
  }) {
    return IncidentHistoryState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      incidents: incidents ?? this.incidents,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        incidents,
      ];
}
