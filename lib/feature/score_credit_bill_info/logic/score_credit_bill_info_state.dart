part of 'score_credit_bill_info_cubit.dart';

class ScoreCreditBillInfoState extends Equatable {
  const ScoreCreditBillInfoState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.isShowingBackgroundAppBar = false,
  });

  final GlobalState status;
  final String errorMessage;
  final bool isShowingBackgroundAppBar;

  ScoreCreditBillInfoState copyWith({
    GlobalState? status,
    String? errorMessage,
    bool? isShowingBackgroundAppBar,
  }) {
    return ScoreCreditBillInfoState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isShowingBackgroundAppBar:
          isShowingBackgroundAppBar ?? this.isShowingBackgroundAppBar,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        isShowingBackgroundAppBar,
      ];
}
