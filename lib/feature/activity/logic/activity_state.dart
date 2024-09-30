part of 'activity_cubit.dart';

class ActivityState extends Equatable {
  const ActivityState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.pondReponse,
    this.pondDashboardResponse,
    this.selectedPondID,
  });

  final GlobalState status;
  final String errorMessage;
  final PondResponse? pondReponse;
  final PondDashboardResponse? pondDashboardResponse;
  final String? selectedPondID;

  ActivityState copyWith({
    GlobalState? status,
    String? errorMessage,
    PondResponse? pondReponse,
    PondDashboardResponse? pondDashboardResponse,
    String? selectedPondID,
  }) {
    return ActivityState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      pondReponse: pondReponse ?? this.pondReponse,
      pondDashboardResponse:
          pondDashboardResponse ?? this.pondDashboardResponse,
      selectedPondID: selectedPondID ?? this.selectedPondID,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        pondReponse,
        pondDashboardResponse,
        selectedPondID,
      ];
}
