part of 'resume_activity_cubit.dart';

class ResumeActivityState extends Equatable {
  const ResumeActivityState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.pondDashboardResponse,
    this.selectedPondID,
    this.fishpond = const [],
  });

  final GlobalState status;
  final String errorMessage;
  final PondDashboardResponse? pondDashboardResponse;
  final String? selectedPondID;
  final List<Fishpond>? fishpond;

  ResumeActivityState copyWith({
    GlobalState? status,
    String? errorMessage,
    PondDashboardResponse? pondDashboardResponse,
    String? selectedPondID,
    List<Fishpond>? fishpond,
  }) {
    return ResumeActivityState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      pondDashboardResponse:
          pondDashboardResponse ?? this.pondDashboardResponse,
      selectedPondID: selectedPondID ?? this.selectedPondID,
      fishpond: fishpond ?? this.fishpond,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        pondDashboardResponse ?? PondDashboardResponse(),
        selectedPondID ?? '',
        fishpond ?? [],
      ];
}
