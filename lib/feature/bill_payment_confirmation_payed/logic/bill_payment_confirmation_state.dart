part of 'bill_payment_confirmation_cubit.dart';

class BillPaymentConfirmationState extends Equatable {
  const BillPaymentConfirmationState({
    this.status = GlobalState.initial,
    this.message = '',
    this.notes = '',
  });

  final GlobalState status;
  final String message;
  final String notes;

  BillPaymentConfirmationState copyWith({
    GlobalState? status,
    String? message,
    String? notes,
  }) {
    return BillPaymentConfirmationState(
      status: status ?? this.status,
      message: message ?? this.message,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
        notes,
      ];
}
