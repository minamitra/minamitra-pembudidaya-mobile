part of 'activity_activities_cubit.dart';

class ActivityActivitiesState extends Equatable {
  const ActivityActivitiesState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.index = 0,
    this.datetime = '',
  });

  final GlobalState status;
  final String errorMessage;
  final int index;
  final String datetime;

  ActivityActivitiesState copyWith({
    GlobalState? status,
    String? errorMessage,
    int? index,
    String? datetime,
  }) {
    return ActivityActivitiesState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      index: index ?? this.index,
      datetime: datetime ?? this.datetime,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        index,
        datetime,
      ];
}
