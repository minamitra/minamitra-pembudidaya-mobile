part of 'activity_feed_cubit.dart';

class ActivityFeedState extends Equatable {
  const ActivityFeedState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
  });

  final GlobalState status;
  final String errorMessage;

  ActivityFeedState copyWith({
    GlobalState? status,
    String? errorMessage,
  }) {
    return ActivityFeedState(
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
