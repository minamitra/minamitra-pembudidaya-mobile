part of 'incident_data_cubit.dart';

class IncidentDataState extends Equatable {
  const IncidentDataState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.incidents,
  });

  final GlobalState status;
  final String errorMessage;
  final List<IncidentResponseData>? incidents;

  IncidentDataState copyWith({
    GlobalState? status,
    String? errorMessage,
    List<IncidentResponseData>? incidents,
  }) {
    return IncidentDataState(
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
