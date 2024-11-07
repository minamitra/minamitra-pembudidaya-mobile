part of 'checkout_cubit.dart';

class CheckoutState extends Equatable {
  const CheckoutState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
  });

  final GlobalState status;
  final String errorMessage;

  CheckoutState copyWith({
    GlobalState? status,
    String? errorMessage,
  }) {
    return CheckoutState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
      ];
}
