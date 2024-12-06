part of 'detail_income_cubit.dart';

class DetailIncomeState extends Equatable {
  const DetailIncomeState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.data,
  });

  final GlobalState status;
  final String errorMessage;
  final FeedCycleHistoryResponseData? data;

  DetailIncomeState copyWith({
    GlobalState? status,
    String? errorMessage,
    FeedCycleHistoryResponseData? data,
  }) {
    return DetailIncomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        data ?? FeedCycleHistoryResponseData(),
      ];
}
