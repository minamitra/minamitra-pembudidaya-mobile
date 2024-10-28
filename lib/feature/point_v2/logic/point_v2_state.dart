part of 'point_v2_cubit.dart';

class PointV2State extends Equatable {
  const PointV2State({
    this.status = GlobalState.initial,
    this.errorMessage = "",
    this.selectedGridExchange = -1,
  });

  final GlobalState status;
  final String errorMessage;
  final int selectedGridExchange;

  PointV2State copyWith({
    GlobalState? status,
    String? errorMessage,
    int? selectedGridExchange,
  }) {
    return PointV2State(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedGridExchange: selectedGridExchange ?? this.selectedGridExchange,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        selectedGridExchange,
      ];
}
