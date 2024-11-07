part of 'point_v2_cubit.dart';

enum BodyPointV2 { mission, exchange }

class PointV2State extends Equatable {
  const PointV2State({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.selectedGridExchange = -1,
    this.bodyPointV2 = BodyPointV2.mission,
  });

  final GlobalState status;
  final String errorMessage;
  final int selectedGridExchange;
  final BodyPointV2 bodyPointV2;

  PointV2State copyWith({
    GlobalState? status,
    String? errorMessage,
    int? selectedGridExchange,
    BodyPointV2? bodyPointV2,
  }) {
    return PointV2State(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedGridExchange: selectedGridExchange ?? this.selectedGridExchange,
      bodyPointV2: bodyPointV2 ?? this.bodyPointV2,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        selectedGridExchange,
        bodyPointV2,
      ];
}
