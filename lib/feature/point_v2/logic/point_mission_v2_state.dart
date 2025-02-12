part of 'point_mission_v2_cubit.dart';

class PointMissionV2State extends Equatable {
  const PointMissionV2State({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.differenceTime = const Duration(),
    this.pointBalance,
    this.pointConfigruation,
    this.missionPoint,
  });

  final GlobalState status;
  final String errorMessage;
  final Duration differenceTime;
  final PointBalanceResponse? pointBalance;
  final PointConfigurationResponse? pointConfigruation;
  final MissionPointResponse? missionPoint;

  PointMissionV2State copyWith({
    GlobalState? status,
    String? errorMessage,
    Duration? differenceTime,
    PointBalanceResponse? pointBalance,
    PointConfigurationResponse? pointConfigruation,
    MissionPointResponse? missionPoint,
  }) {
    return PointMissionV2State(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      differenceTime: differenceTime ?? this.differenceTime,
      pointBalance: pointBalance ?? this.pointBalance,
      pointConfigruation: pointConfigruation ?? this.pointConfigruation,
      missionPoint: missionPoint ?? this.missionPoint,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        differenceTime,
        pointBalance ?? PointBalanceResponse(),
        pointConfigruation ?? PointConfigurationResponse(),
        missionPoint ?? MissionPointResponse(),
      ];
}
