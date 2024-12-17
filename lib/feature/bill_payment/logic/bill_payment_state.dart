part of 'bill_payment_cubit.dart';

class BillPaymentState extends Equatable {
  const BillPaymentState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.isShowingBackgroundAppBar = false,
  });

  final GlobalState status;
  final String errorMessage;
  final bool isShowingBackgroundAppBar;

  BillPaymentState copyWith({
    GlobalState? status,
    String? errorMessage,
    bool? isShowingBackgroundAppBar,
  }) {
    return BillPaymentState(
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
