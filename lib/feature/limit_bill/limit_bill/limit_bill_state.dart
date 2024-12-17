part of 'limit_bill_cubit.dart';

class LimitBillState extends Equatable {
  const LimitBillState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.isShowingBackgroundAppBar = false,
  });

  final GlobalState status;
  final String errorMessage;
  final bool isShowingBackgroundAppBar;

  LimitBillState copyWith({
    GlobalState? status,
    String? errorMessage,
    bool? isShowingBackgroundAppBar,
  }) {
    return LimitBillState(
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
