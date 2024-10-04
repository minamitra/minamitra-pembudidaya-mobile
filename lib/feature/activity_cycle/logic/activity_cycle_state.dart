part of 'activity_cycle_cubit.dart';

class ActivityCycleState extends Equatable {
  const ActivityCycleState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
    this.activeData,
    this.readyHarvestData,
    this.harvestData,
    this.doneData,
  });

  final GlobalState status;
  final String errorMessage;
  final FeedCycleHistoryResponse? activeData;
  final FeedCycleHistoryResponse? readyHarvestData;
  final FeedCycleHistoryResponse? harvestData;
  final FeedCycleHistoryResponse? doneData;

  ActivityCycleState copyWith({
    GlobalState? status,
    String? errorMessage,
    FeedCycleHistoryResponse? activeData,
    FeedCycleHistoryResponse? readyHarvestData,
    FeedCycleHistoryResponse? harvestData,
    FeedCycleHistoryResponse? doneData,
  }) {
    return ActivityCycleState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      activeData: activeData ?? this.activeData,
      readyHarvestData: readyHarvestData ?? this.readyHarvestData,
      harvestData: harvestData ?? this.harvestData,
      doneData: doneData ?? this.doneData,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        activeData,
        readyHarvestData,
        harvestData,
        doneData,
      ];
}
