part of 'bill_payment_pay_cubit.dart';

class BillPaymentPayState extends Equatable {
  const BillPaymentPayState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.payments = const [],
    this.selectedPayment,
  });

  final GlobalState status;
  final String errorMessage;
  final List<SelectedPayment> payments;
  final SelectedPayment? selectedPayment;

  BillPaymentPayState copyWith({
    GlobalState? status,
    String? errorMessage,
    List<SelectedPayment>? payments,
    SelectedPayment? selectedPayment,
  }) {
    return BillPaymentPayState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      payments: payments ?? this.payments,
      selectedPayment: selectedPayment ?? this.selectedPayment,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        payments,
        selectedPayment,
      ];
}
