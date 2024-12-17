part of 'add_pond_third_step_cubit.dart';

class AddPondThirdStepState extends Equatable {
  const AddPondThirdStepState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.feedStarter1Data,
    this.feedStarter2Data,
    this.feedStarter3Data,
    this.feedGrowerData,
    this.feedFinisherData,
    this.seedResponse,
    this.commodityData = const [],
  });

  final GlobalState status;
  final String errorMessage;
  final FeedStarterResponse? feedStarter1Data;
  final FeedStarterResponse? feedStarter2Data;
  final FeedStarterResponse? feedStarter3Data;
  final FeedGrowerResponse? feedGrowerData;
  final FeedFinisherResponse? feedFinisherData;
  final SeedResponse? seedResponse;
  final List<CommodityResponseData> commodityData;

  AddPondThirdStepState copyWith({
    GlobalState? status,
    String? errorMessage,
    FeedStarterResponse? feedStarter1Data,
    FeedStarterResponse? feedStarter2Data,
    FeedStarterResponse? feedStarter3Data,
    FeedGrowerResponse? feedGrowerData,
    FeedFinisherResponse? feedFinisherData,
    SeedResponse? seedResponse,
    List<CommodityResponseData>? commodityData,
  }) {
    return AddPondThirdStepState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      feedStarter1Data: feedStarter1Data ?? this.feedStarter1Data,
      feedStarter2Data: feedStarter2Data ?? this.feedStarter2Data,
      feedStarter3Data: feedStarter3Data ?? this.feedStarter3Data,
      feedGrowerData: feedGrowerData ?? this.feedGrowerData,
      feedFinisherData: feedFinisherData ?? this.feedFinisherData,
      seedResponse: seedResponse ?? this.seedResponse,
      commodityData: commodityData ?? this.commodityData,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        feedStarter1Data,
        feedStarter2Data,
        feedStarter3Data,
        feedGrowerData,
        feedFinisherData,
        seedResponse,
        commodityData,
      ];
}
