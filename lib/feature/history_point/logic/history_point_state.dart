part of 'history_point_cubit.dart';

class HistoryPointState extends Equatable {
  const HistoryPointState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.selectedFilter = 'Selesai',
    this.selectedDate,
    this.pointHistoryResponse,
    this.withdrawalData,
    this.convertBalanceData,
  });

  final GlobalState status;
  final String errorMessage;
  final String selectedFilter;
  final DateTime? selectedDate;
  final PointHistoryResponse? pointHistoryResponse;
  final PointExchangeHistoryResponse? withdrawalData;
  final PointExchangeHistoryResponse? convertBalanceData;

  HistoryPointState copyWith({
    GlobalState? status,
    String? errorMessage,
    String? selectedFilter,
    DateTime? selectedDate,
    PointHistoryResponse? pointHistoryResponse,
    PointExchangeHistoryResponse? withdrawalData,
    PointExchangeHistoryResponse? convertBalanceData,
  }) {
    return HistoryPointState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      selectedDate: selectedDate,
      pointHistoryResponse: pointHistoryResponse ?? this.pointHistoryResponse,
      withdrawalData: withdrawalData ?? this.withdrawalData,
      convertBalanceData: convertBalanceData ?? this.convertBalanceData,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        selectedFilter,
        selectedDate ?? DateTime.now(),
        pointHistoryResponse ?? PointHistoryResponse(),
        withdrawalData ?? PointExchangeHistoryResponse(),
        convertBalanceData ?? PointExchangeHistoryResponse(),
      ];
}
