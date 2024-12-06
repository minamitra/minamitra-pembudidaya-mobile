part of 'production_cost_detail_cubit.dart';

class ProductionCostDetailState extends Equatable {
  const ProductionCostDetailState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.financeResponseData,
    this.otherCostData,
    this.fishPondID = '0',
  });

  final GlobalState status;
  final String errorMessage;
  final FinanceResponseData? financeResponseData;
  final FishpondCycleCostResponse? otherCostData;
  final String fishPondID;

  ProductionCostDetailState copyWith({
    GlobalState? status,
    String? errorMessage,
    FinanceResponseData? financeResponseData,
    FishpondCycleCostResponse? otherCostData,
    String? fishPondID,
  }) {
    return ProductionCostDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      financeResponseData: financeResponseData ?? this.financeResponseData,
      otherCostData: otherCostData ?? this.otherCostData,
      fishPondID: fishPondID ?? this.fishPondID,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        financeResponseData ?? FinanceResponseData(),
        otherCostData ?? FishpondCycleCostResponse(),
      ];
}
