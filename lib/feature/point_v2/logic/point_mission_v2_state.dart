part of 'point_mission_v2_cubit.dart';

class PointMissionV2State extends Equatable {
  const PointMissionV2State({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.differenceTime = const Duration(),
  });

  final GlobalState status;
  final String errorMessage;
  final Duration differenceTime;

  PointMissionV2State copyWith({
    GlobalState? status,
    String? errorMessage,
    Duration? differenceTime,
  }) {
    return PointMissionV2State(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      differenceTime: differenceTime ?? this.differenceTime,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        differenceTime,
      ];
}
