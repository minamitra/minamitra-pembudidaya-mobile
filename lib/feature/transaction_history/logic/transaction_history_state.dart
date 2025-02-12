part of 'transaction_history_cubit.dart';

class TransactionHistoryState extends Equatable {
  const TransactionHistoryState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.historyBalance,
    this.dataFormated,
  });

  final GlobalState status;
  final String errorMessage;
  final HistoryBalanceResponse? historyBalance;
  final Map<String, List<HistoryBalanceResponseData>>? dataFormated;

  TransactionHistoryState copyWith({
    GlobalState? status,
    String? errorMessage,
    HistoryBalanceResponse? historyBalance,
    Map<String, List<HistoryBalanceResponseData>>? dataFormated,
  }) {
    return TransactionHistoryState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      historyBalance: historyBalance ?? this.historyBalance,
      dataFormated: dataFormated ?? this.dataFormated,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        historyBalance ?? '',
        dataFormated ?? {},
      ];
}
