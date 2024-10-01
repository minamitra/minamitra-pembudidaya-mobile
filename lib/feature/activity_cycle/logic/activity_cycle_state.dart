part of 'activity_cycle_cubit.dart';

class ActivityCycleState extends Equatable {
  const ActivityCycleState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
    this.activeData,
    this.harvestData,
    this.doneData,
  });

  final GlobalState status;
  final String errorMessage;
  final FeedCycleHistoryResponse? activeData;
  final FeedCycleHistoryResponse? harvestData;
  final FeedCycleHistoryResponse? doneData;

  ActivityCycleState copyWith({
    GlobalState? status,
    String? errorMessage,
    FeedCycleHistoryResponse? activeData,
    FeedCycleHistoryResponse? harvestData,
    FeedCycleHistoryResponse? doneData,
  }) {
    return ActivityCycleState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      activeData: activeData ?? this.activeData,
      harvestData: harvestData ?? this.harvestData,
      doneData: doneData ?? this.doneData,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        activeData,
        harvestData,
        doneData,
      ];
}
