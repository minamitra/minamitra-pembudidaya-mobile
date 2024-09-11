part of 'activity_activities_cubit.dart';

class ActivityActivitiesState extends Equatable {
  const ActivityActivitiesState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.index = 0,
  });

  final GlobalState status;
  final String errorMessage;
  final int index;

  ActivityActivitiesState copyWith({
    GlobalState? status,
    String? errorMessage,
    int? index,
  }) {
    return ActivityActivitiesState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      index: index ?? this.index,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        index,
      ];
}
