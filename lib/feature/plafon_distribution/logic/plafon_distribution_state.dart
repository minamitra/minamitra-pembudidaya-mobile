part of 'plafon_distribution_cubit.dart';

class PlafonDistributionState extends Equatable {
  const PlafonDistributionState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.showingShowMore = true,
    this.plafonSummaryResponse,
    this.plafonDistributionResponse,
    this.plafonUseSummaryResponse,
    this.plafonFeedUseResponse,
    this.plafonTreatmentUseResponse,
    this.plafonSeedUseResponse,
    this.plafonAnotherUseResponse,
    this.selectedPond = '',
  });

  final GlobalState status;
  final String errorMessage;
  final bool showingShowMore;
  final PlafonSummaryResponse? plafonSummaryResponse;
  final PlafonDistributionResponse? plafonDistributionResponse;
  final PlafonDistributionSummaryResponse? plafonUseSummaryResponse;
  final BaseResponse<DetailFeedUseResponse>? plafonFeedUseResponse;
  final BaseResponse<DetailTreatmentUseResponse>? plafonTreatmentUseResponse;
  final BaseResponse<DetailSeedUseResponse>? plafonSeedUseResponse;
  final BaseResponse<DetailAnotherUseResponse>? plafonAnotherUseResponse;
  final String selectedPond;

  PlafonDistributionState copyWith({
    GlobalState? status,
    String? errorMessage,
    bool? showingShowMore,
    PlafonSummaryResponse? plafonSummaryResponse,
    PlafonDistributionResponse? plafonDistributionResponse,
    PlafonDistributionSummaryResponse? plafonUseSummaryResponse,
    BaseResponse<DetailFeedUseResponse>? plafonFeedUseResponse,
    BaseResponse<DetailTreatmentUseResponse>? plafonTreatmentUseResponse,
    BaseResponse<DetailSeedUseResponse>? plafonSeedUseResponse,
    BaseResponse<DetailAnotherUseResponse>? plafonAnotherUseResponse,
    String? selectedPond,
  }) {
    return PlafonDistributionState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      showingShowMore: showingShowMore ?? this.showingShowMore,
      plafonSummaryResponse:
          plafonSummaryResponse ?? this.plafonSummaryResponse,
      plafonDistributionResponse:
          plafonDistributionResponse ?? this.plafonDistributionResponse,
      plafonUseSummaryResponse:
          plafonUseSummaryResponse ?? this.plafonUseSummaryResponse,
      plafonFeedUseResponse:
          plafonFeedUseResponse ?? this.plafonFeedUseResponse,
      plafonTreatmentUseResponse:
          plafonTreatmentUseResponse ?? this.plafonTreatmentUseResponse,
      plafonSeedUseResponse:
          plafonSeedUseResponse ?? this.plafonSeedUseResponse,
      plafonAnotherUseResponse:
          plafonAnotherUseResponse ?? this.plafonAnotherUseResponse,
      selectedPond: selectedPond ?? this.selectedPond,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        showingShowMore,
        plafonSummaryResponse ?? '',
        plafonDistributionResponse ?? '',
        plafonUseSummaryResponse ?? '',
        plafonFeedUseResponse ?? '',
        plafonTreatmentUseResponse ?? '',
        plafonSeedUseResponse ?? '',
        plafonAnotherUseResponse ?? '',
        selectedPond,
      ];
}
