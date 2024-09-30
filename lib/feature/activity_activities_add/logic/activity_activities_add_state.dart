part of 'activity_activities_add_cubit.dart';

class ActivityActivitiesAddState extends Equatable {
  const ActivityActivitiesAddState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.selectedDate,
    this.feedRecomendationResponse,
    this.feedDataByCycleResponse,
    this.fishAge = 0,
    this.fishFoodID = 0,
  });

  final GlobalState status;
  final String errorMessage;
  final DateTime? selectedDate;
  final FeedRecomendationResponse? feedRecomendationResponse;
  final FeedDataByCycleResponse? feedDataByCycleResponse;
  final int fishAge;
  final int fishFoodID;

  ActivityActivitiesAddState copyWith({
    GlobalState? status,
    String? errorMessage,
    DateTime? selectedDate,
    FeedRecomendationResponse? feedRecomendationResponse,
    FeedDataByCycleResponse? feedDataByCycleResponse,
    int? fishAge,
    int? fishFoodID,
  }) {
    return ActivityActivitiesAddState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedDate: selectedDate ?? this.selectedDate,
      feedRecomendationResponse:
          feedRecomendationResponse ?? this.feedRecomendationResponse,
      feedDataByCycleResponse:
          feedDataByCycleResponse ?? this.feedDataByCycleResponse,
      fishAge: fishAge ?? this.fishAge,
      fishFoodID: fishFoodID ?? this.fishFoodID,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        selectedDate,
        feedRecomendationResponse,
        feedDataByCycleResponse,
        fishAge,
        fishFoodID,
      ];
}
