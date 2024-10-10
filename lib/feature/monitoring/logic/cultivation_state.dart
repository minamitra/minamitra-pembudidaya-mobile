part of 'cultivation_cubit.dart';

class CultivationState extends Equatable {
  const CultivationState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
    this.data,
  });

  final GlobalState status;
  final String errorMessage;
  final GraphResponseData? data;

  CultivationState copyWith({
    GlobalState? status,
    String? errorMessage,
    GraphResponseData? data,
  }) {
    return CultivationState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        data ?? GraphResponseData(),
      ];
}
