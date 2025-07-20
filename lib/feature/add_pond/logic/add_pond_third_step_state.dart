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
    this.recommendStarter1,
    this.recommendStarter2,
    this.recommendStarter3,
    this.recommendGrower,
    this.recommendFinisher,
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
  final FeedStarterResponseData? recommendStarter1;
  final FeedStarterResponseData? recommendStarter2;
  final FeedStarterResponseData? recommendStarter3;
  final FeedGrowerResponseData? recommendGrower;
  final FeedFinisherResponseData? recommendFinisher;

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
    FeedStarterResponseData? recommendStarter1,
    FeedStarterResponseData? recommendStarter2,
    FeedStarterResponseData? recommendStarter3,
    FeedGrowerResponseData? recommendGrower,
    FeedFinisherResponseData? recommendFinisher,
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
      recommendStarter1: recommendStarter1 ?? this.recommendStarter1,
      recommendStarter2: recommendStarter2 ?? this.recommendStarter2,
      recommendStarter3: recommendStarter3 ?? this.recommendStarter3,
      recommendGrower: recommendGrower ?? this.recommendGrower,
      recommendFinisher: recommendFinisher ?? this.recommendFinisher,
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
        recommendStarter1,
        recommendStarter2,
        recommendStarter3,
        recommendGrower,
        recommendFinisher,
      ];
}
