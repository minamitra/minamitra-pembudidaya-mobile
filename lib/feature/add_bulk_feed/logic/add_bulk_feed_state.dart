part of 'add_bulk_feed_cubit.dart';

class AddBulkFeedState extends Equatable {
  const AddBulkFeedState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
    this.recommendationFeedBulk,
    this.pickedDate,
  });

  final GlobalState status;
  final String errorMessage;
  final RecommendationFeedBulk? recommendationFeedBulk;
  final DateTime? pickedDate;

  AddBulkFeedState copyWith({
    GlobalState? status,
    String? errorMessage,
    RecommendationFeedBulk? recommendationFeedBulk,
    DateTime? pickedDate,
  }) {
    return AddBulkFeedState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      recommendationFeedBulk:
          recommendationFeedBulk ?? this.recommendationFeedBulk,
      pickedDate: pickedDate ?? this.pickedDate,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        recommendationFeedBulk,
        pickedDate,
      ];
}
