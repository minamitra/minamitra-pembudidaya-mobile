part of 'bill_detail_cubit.dart';

class BillDetailState extends Equatable {
  const BillDetailState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.isShowingBackgroundAppBar = false,
    this.plafonUseSummary,
    this.plafonFeedUse,
    this.plafonTreatmentUse,
    this.plafonSeedUse,
    this.plafonAnotherUse,
    this.dummyCount = 111111111,
    this.listBillPayed,
  });

  final GlobalState status;
  final String errorMessage;
  final bool isShowingBackgroundAppBar;
  final PlafonDistributionSummaryResponse? plafonUseSummary;
  final DetailFeedUseResponse? plafonFeedUse;
  final DetailTreatmentUseResponse? plafonTreatmentUse;
  final DetailSeedUseResponse? plafonSeedUse;
  final DetailAnotherUseResponse? plafonAnotherUse;
  final int dummyCount;
  final ListBillPayedResponse? listBillPayed;

  BillDetailState copyWith({
    GlobalState? status,
    String? errorMessage,
    bool? isShowingBackgroundAppBar,
    PlafonDistributionSummaryResponse? plafonUseSummary,
    DetailFeedUseResponse? plafonFeedUse,
    DetailTreatmentUseResponse? plafonTreatmentUse,
    DetailSeedUseResponse? plafonSeedUse,
    DetailAnotherUseResponse? plafonAnotherUse,
    int? dummyCount,
    ListBillPayedResponse? listBillPayed,
  }) {
    return BillDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isShowingBackgroundAppBar:
          isShowingBackgroundAppBar ?? this.isShowingBackgroundAppBar,
      plafonUseSummary: plafonUseSummary ?? this.plafonUseSummary,
      plafonFeedUse: plafonFeedUse ?? this.plafonFeedUse,
      plafonTreatmentUse: plafonTreatmentUse ?? this.plafonTreatmentUse,
      plafonSeedUse: plafonSeedUse ?? this.plafonSeedUse,
      plafonAnotherUse: plafonAnotherUse ?? this.plafonAnotherUse,
      dummyCount: dummyCount ?? this.dummyCount,
      listBillPayed: listBillPayed ?? this.listBillPayed,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        isShowingBackgroundAppBar,
        plafonUseSummary ?? '',
        plafonFeedUse ?? '',
        plafonTreatmentUse ?? '',
        plafonSeedUse ?? '',
        plafonAnotherUse ?? '',
        dummyCount,
        listBillPayed ?? '',
      ];
}
