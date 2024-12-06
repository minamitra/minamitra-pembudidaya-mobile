part of 'finance_cubit.dart';

class FinanceState extends Equatable {
  const FinanceState({
    this.status = GlobalState.initial,
    this.error = '',
    this.financeSummary,
    this.finance,
  });

  final GlobalState status;
  final String? error;
  final FinanceSummaryResponse? financeSummary;
  final FinanceResponse? finance;

  FinanceState copyWith({
    GlobalState? status,
    String? error,
    FinanceSummaryResponse? financeSummary,
    FinanceResponse? finance,
  }) {
    return FinanceState(
      status: status ?? this.status,
      error: error ?? this.error,
      financeSummary: financeSummary ?? this.financeSummary,
      finance: finance ?? this.finance,
    );
  }

  @override
  List<Object> get props => [
        status,
        error ?? '',
        financeSummary ?? FinanceSummaryResponse(),
        finance ?? FinanceResponse(),
      ];
}
