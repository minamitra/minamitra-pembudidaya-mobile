part of 'detail_activity_cubit.dart';

class DetailActivityState extends Equatable {
  const DetailActivityState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.onGoingCycleFeedResponseData,
  });

  final GlobalState status;
  final String errorMessage;
  final OnGoingCycleFeedResponse? onGoingCycleFeedResponseData;

  DetailActivityState copyWith({
    GlobalState? status,
    String? errorMessage,
    OnGoingCycleFeedResponse? onGoingCycleFeedResponseData,
  }) {
    return DetailActivityState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      onGoingCycleFeedResponseData:
          onGoingCycleFeedResponseData ?? this.onGoingCycleFeedResponseData,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        onGoingCycleFeedResponseData,
      ];
}
