part of 'point_exchange_cubit.dart';

class PointExchangeState extends Equatable {
  const PointExchangeState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
  });

  final GlobalState status;
  final String errorMessage;

  PointExchangeState copyWith({
    GlobalState? status,
    String? errorMessage,
  }) {
    return PointExchangeState(
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
