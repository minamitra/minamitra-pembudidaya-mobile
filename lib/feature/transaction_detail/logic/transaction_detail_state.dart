part of 'transaction_detail_cubit.dart';

class TransactionDetailState extends Equatable {
  const TransactionDetailState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.deliveryStatus,
  });

  final GlobalState status;
  final String errorMessage;
  final DeliveryStatusResponse? deliveryStatus;

  TransactionDetailState copyWith({
    GlobalState? status,
    String? errorMessage,
    DeliveryStatusResponse? deliveryStatus,
  }) {
    return TransactionDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        deliveryStatus,
      ];
}
