part of 'activity_activities_detail_cubit.dart';

class ActivityActivitiesDetailState extends Equatable {
  const ActivityActivitiesDetailState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
  });

  final GlobalState status;
  final String errorMessage;

  ActivityActivitiesDetailState copyWith({
    GlobalState? status,
    String? errorMessage,
  }) {
    return ActivityActivitiesDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
      ];
}
