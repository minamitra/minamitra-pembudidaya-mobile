part of 'bill_payment_cubit.dart';

class BillPaymentState extends Equatable {
  const BillPaymentState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.isShowingBackgroundAppBar = false,
    this.billSummaryResponse,
    this.plafonSummaryResponse,
    this.dummyCount = 111111111,
  });

  final GlobalState status;
  final String errorMessage;
  final bool isShowingBackgroundAppBar;
  final BillSummaryResponse? billSummaryResponse;
  final PlafonSummaryResponse? plafonSummaryResponse;
  final int dummyCount;

  BillPaymentState copyWith({
    GlobalState? status,
    String? errorMessage,
    bool? isShowingBackgroundAppBar,
    BillSummaryResponse? billSummaryResponse,
    PlafonSummaryResponse? plafonSummaryResponse,
    int? dummyCount,
  }) {
    return BillPaymentState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isShowingBackgroundAppBar:
          isShowingBackgroundAppBar ?? this.isShowingBackgroundAppBar,
      billSummaryResponse: billSummaryResponse ?? this.billSummaryResponse,
      plafonSummaryResponse:
          plafonSummaryResponse ?? this.plafonSummaryResponse,
      dummyCount: dummyCount ?? this.dummyCount,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        isShowingBackgroundAppBar,
        billSummaryResponse ?? '',
        plafonSummaryResponse ?? '',
        dummyCount,
      ];
}
