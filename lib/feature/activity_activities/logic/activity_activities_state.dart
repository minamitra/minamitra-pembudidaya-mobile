part of 'activity_activities_cubit.dart';

class ActivityActivitiesState extends Equatable {
  const ActivityActivitiesState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.index = 0,
    this.feedActivityResponse,
    this.selectedDate,
    this.pondCycleID,
  });

  final GlobalState status;
  final String errorMessage;
  final int index;
  final FeedActivityResponse? feedActivityResponse;
  final DateTime? selectedDate;
  final String? pondCycleID;

  ActivityActivitiesState copyWith({
    GlobalState? status,
    String? errorMessage,
    int? index,
    FeedActivityResponse? feedActivityResponse,
    DateTime? selectedDate,
    String? pondCycleID,
  }) {
    return ActivityActivitiesState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      index: index ?? this.index,
      feedActivityResponse: feedActivityResponse ?? this.feedActivityResponse,
      selectedDate: selectedDate ?? this.selectedDate,
      pondCycleID: pondCycleID ?? this.pondCycleID,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        index,
        feedActivityResponse,
        selectedDate,
        pondCycleID,
      ];
}
