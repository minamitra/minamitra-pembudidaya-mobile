part of 'finance_detail_cubit.dart';

class FinanceDetailState extends Equatable {
  const FinanceDetailState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.otherCost,
    this.cycleDetail,
    this.data,
  });

  final GlobalState status;
  final String errorMessage;
  final FishpondCycleCostResponse? otherCost;
  final FeedCycleHistoryResponseData? cycleDetail;
  final FinanceResponseData? data;

  FinanceDetailState copyWith({
    GlobalState? status,
    String? errorMessage,
    FishpondCycleCostResponse? otherCost,
    FeedCycleHistoryResponseData? cycleDetail,
    FinanceResponseData? data,
  }) {
    return FinanceDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      otherCost: otherCost ?? this.otherCost,
      cycleDetail: cycleDetail ?? this.cycleDetail,
      data: data ?? this.data,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        otherCost ?? FishpondCycleCostResponse(),
        cycleDetail ?? FeedCycleHistoryResponseData(),
      ];
}
